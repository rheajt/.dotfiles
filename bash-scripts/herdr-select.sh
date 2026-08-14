#!/usr/bin/env bash

set -euo pipefail

SCRIPT_PATH=$(readlink -f "$0" 2>/dev/null || printf '%s/%s' "$PWD" "$0")

die() {
    printf 'herdr-select: %s\n' "$1" >&2
    exit 1
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || die "$1 is required but was not found in PATH"
}

preview() {
    local kind=$1
    local target=$2

    printf '\033[1;38;5;214m  HERDR %s\033[0m\n\n' \
        "$( [[ $kind == A ]] && printf 'AGENT' || printf 'PANE' )"

    printf '\n\033[1;38;5;214m  RECENT OUTPUT · last 80 lines\033[0m\n'
    herdr pane read "$target" --source recent-unwrapped --lines 80 2>&1 || true
}

focus_pane() {
    local target=$1
    local fresh_panes tab_id layout current neighbor_json neighbor
    local source direction node
    local -a directions=(left right up down)
    local -a queue_ids=()
    local -a step_panes=()
    local -a step_directions=()
    local queue_index=0
    local found=0
    local i
    declare -A allowed=()
    declare -A visited=()
    declare -A previous=()
    declare -A previous_direction=()

    fresh_panes=$(herdr pane list 2>/dev/null) ||
        die 'could not refresh Herdr panes before focusing'
    tab_id=$(printf '%s\n' "$fresh_panes" | jq -r --arg id "$target" '
        [.result.panes[]? | select(.pane_id == $id) | .tab_id][0] // empty') ||
        die "could not find pane $target in the refreshed pane list"
    [[ -n $tab_id ]] || die "pane $target is no longer available"

    herdr tab focus "$tab_id" || die "could not focus tab $tab_id for pane $target"

    layout=$(herdr pane layout --pane "$target" 2>/dev/null) ||
        die "could not query the layout for pane $target"
    current=$(printf '%s\n' "$layout" | jq -r \
        '.result.layout.focused_pane_id // empty') ||
        die "could not determine the focused pane for pane $target"
    [[ -n $current ]] || die "the layout for pane $target has no focused pane"

    if [[ $current == "$target" ]]; then
        printf 'Focused pane %s.\n' "$target"
        return 0
    fi

    while IFS= read -r node; do
        [[ -n $node ]] && allowed["$node"]=1
    done < <(printf '%s\n' "$layout" | jq -r '.result.layout.panes[]?.pane_id // empty')

    [[ ${allowed[$current]+yes} ]] ||
        die "the focused pane $current is not in the layout for pane $target"
    [[ ${allowed[$target]+yes} ]] ||
        die "pane $target is not in its reported layout"
    queue_ids+=("$current")
    visited["$current"]=1

    while (( queue_index < ${#queue_ids[@]} )); do
        source=${queue_ids[$queue_index]}
        ((queue_index += 1))

        for direction in "${directions[@]}"; do
            neighbor_json=$(herdr pane neighbor --pane "$source" \
                --direction "$direction" 2>/dev/null) || continue
            neighbor=$(printf '%s\n' "$neighbor_json" | jq -r \
                '.result.neighbor.neighbor_pane_id // empty') || continue
            [[ -n $neighbor && ${allowed[$neighbor]+yes} ]] || continue
            [[ ${visited[$neighbor]+yes} ]] && continue

            visited["$neighbor"]=1
            previous["$neighbor"]=$source
            previous_direction["$neighbor"]=$direction
            queue_ids+=("$neighbor")

            if [[ $neighbor == "$target" ]]; then
                found=1
                break 2
            fi
        done
    done

    (( found )) || die "could not find a focus path from pane $current to pane $target"

    node=$target
    while [[ $node != "$current" ]]; do
        step_panes=("$node" "${step_panes[@]}" )
        step_directions=("${previous_direction[$node]}" "${step_directions[@]}" )
        node=${previous[$node]}
    done

    source=$current
    for ((i = 0; i < ${#step_panes[@]}; i += 1)); do
        direction=${step_directions[$i]}
        herdr pane focus --pane "$source" --direction "$direction" ||
            die "could not focus pane $target from pane $source toward $direction"
        source=${step_panes[$i]}
    done

    printf 'Focused pane %s.\n' "$target"
}

if [[ ${1:-} == --preview ]]; then
    require_command herdr
    require_command jq
    preview "${2:-}" "${3:-}"
    exit 0
fi

require_command herdr
require_command jq

if [[ ${1:-} != --records && ${1:-} != --records-internal ]]; then
    require_command fzf
    [[ -t 0 && -t 1 ]] || die 'an interactive terminal is required'
fi

# api snapshot is deliberately used as a harmless readiness check. It also
# avoids launching Herdr when this helper is run outside a managed session.
if ! herdr api snapshot >/dev/null 2>&1; then
    die 'the Herdr server is unavailable; run this from a live Herdr session'
fi

panes=$(herdr pane list 2>/dev/null) || die 'could not list Herdr panes'
workspaces=$(herdr workspace list 2>/dev/null) || die 'could not list Herdr workspaces'

pane_records=$(jq -nr --argjson workspaces "$workspaces" --argjson panes "$panes" '
    def text:
        if type == "string" then test("\\S") else false end;
    def metadata_field($field):
        .metadata // {} | if type == "object" then .[$field] else empty end;
    def cwd_name:
        [.cwd, .foreground_cwd, .working_directory, .directory,
         metadata_field("cwd"), metadata_field("foreground_cwd")]
        | map(select(text) | sub("/+$"; "") | split("/") | .[-1] | select(text))
        | .[0] // "";
    def pane_name:
        ([.label, metadata_field("title"), .name, .pane_name,
          .terminal_title_stripped, .terminal_title]
         | map(select(text)) | .[0] // "") as $name |
        if ($name | text) then $name
        else (cwd_name) as $cwd |
            if ($cwd | text) then $cwd
            else ([.agent] | map(select(text)) | .[0] // "Unnamed pane")
            end
        end;
    ($workspaces.result.workspaces // []) as $ws |
    ($panes.result.panes // [])[]? |
    .workspace_id as $workspace |
    ($ws | map(select(.workspace_id == $workspace) | .label | select(text)) | .[0] // "Unnamed workspace") as $workspace_name |
    (pane_name) as $pane_name |
    (if (.agent | text) then "AGENT" else "PANE" end) as $kind_name |
    [$workspace_name + "/" + $kind_name + " : " + $pane_name,
     .pane_id, (if (.agent | text) then "A" else "P" end)] | @tsv')
records=$pane_records

[[ -n $records ]] || die 'no Herdr agents or panes are currently available'

if [[ ${1:-} == --records || ${1:-} == --records-internal ]]; then
    if [[ ${1:-} == --records-internal ]]; then
        printf '%s\n' "$records"
    else
        printf '%s\n' "$records" | while IFS=$'\t' read -r display _target _kind; do
            printf '%s\n' "$display"
        done
    fi
    exit 0
fi

fzf_args=(
    --ansi
    --border=rounded
    --cycle
    --delimiter=$'\t'
    --nth=1
    --header=$'↑/↓ navigate   enter focus   esc close   ctrl-r refresh'
    --height=86%
    --layout=reverse
    --no-multi
    --pointer='▌'
    --prompt='  herdr / '
    --preview="$SCRIPT_PATH --preview {3} {2}"
    --preview-window='right,60%,border-left,wrap'
    --color='bg:-1,fg:#d0d0d0,hl:#f2b84b,fg+:#fff7e6,bg+:#3a2c18,hl+:#ffd166,border:#6b5530,spinner:#ffd166,header:#8c7a5b,pointer:#ffd166,info:#8c7a5b'
)

# Herdr exposes floating terminals as config-bound commands with
# type = "popup"; its installed CLI has no popup-launch subcommand. This
# script is therefore the popup payload and must be bound as that command.
selected=$(printf '%s\n' "$records" | fzf "${fzf_args[@]}" --bind="ctrl-r:reload($SCRIPT_PATH --records-internal)") || exit 0

IFS=$'\t' read -r _display target kind <<< "$selected"
focus_pane "$target"
