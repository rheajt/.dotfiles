-- ============================================================================
-- Sidekick + Copilot (deferred loading)
-- ============================================================================

-- Custom prompts are just data -- cheap to define eagerly
local custom_prompts = {
    grammar = {
        description = "Correct grammar",
        prompt = "Correct the {buffer} to standard English, but keep any code blocks inside intact.",
    },
    extract_keywords_buffer = {
        description = "Extract keywords",
        prompt = "Extract the main keywords from the {buffer}",
    },
    readability_selection = {
        description = "Code readability analysis",
        prompt = [[
          You must identify any readability issues in the {selection}
          Some readability issues to consider:
          - Unclear naming
          - Unclear purpose
          - Redundant or obvious comments
          - Lack of comments
          - Long or complex one liners
          - Too much nesting
          - Long variable names
          - Inconsistent naming and code style.
          - Code repetition
          You may identify additional problems. The user submits a small section of code from a larger file.
          Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
          If there's no issues with code respond with only: <OK>
        ]],
    },
    optimize_buffer = {
        description = "Optimize code",
        prompt = "Optimize the code in this {buffer} in a few sentences",
    },
    summarize_selection = {
        description = "Summarize selection",
        prompt = "Summarize the {selection} in a few sentences",
    },
    translate = {
        description = "Translate to Chinese",
        prompt = "Translate {selection} into Chinese, but keep any code blocks inside intact",
    },
    explain = {
        description = "Explain code",
        prompt = "Explain the code in this {buffer}",
    },
    complete = {
        description = "Complete code",
        prompt = "Complete the {selection} written in " .. vim.bo.filetype,
    },
    docstring = {
        description = "Add docstrings",
        prompt = "Add docstrings to the {buffer}",
    },
    fix_bugs = {
        description = "Fix bugs",
        prompt = "Fix the bugs inside the {buffer}, if any",
    },
    tests = {
        description = "Add tests",
        prompt = "Implement tests for the current {buffer}",
    },
    refactor = {
        description = "Refactor the buffer",
        prompt = "Refactor the code in the current {buffer}",
    },
}

local prompts = {}
for key, value in pairs(custom_prompts) do
    prompts[key] = value.prompt
end

-- ============================================================================
-- Copilot (deferred to InsertEnter)
-- ============================================================================

local copilot_loaded = false

local function ensure_copilot()
    if copilot_loaded then
        return
    end
    copilot_loaded = true

    vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
    require("copilot").setup({
        filetypes = {
            norg = false,
            ["snacks.picker"] = false,
        },
        suggestion = { enabled = true, auto_trigger = true },
    })
end

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("twelve-copilot-defer", { clear = true }),
    once = true,
    callback = ensure_copilot,
})

-- ============================================================================
-- Sidekick (deferred to first keypress)
-- ============================================================================

local sidekick_loaded = false

local function ensure_sidekick()
    if sidekick_loaded then
        return
    end
    sidekick_loaded = true

    -- Copilot must be available for sidekick
    ensure_copilot()

    vim.pack.add({ "https://github.com/folke/sidekick.nvim" })
    require("sidekick").setup({
        cli = {
            mux = {
                backend = "tmux",
                enabled = true,
            },
            prompts = prompts,
        },
    })
end

-- ============================================================================
-- Keymaps (always defined -- functions require() on demand)
-- ============================================================================

vim.keymap.set("n", "<tab>", function()
    ensure_sidekick()
    if not require("sidekick").nes_jump_or_apply() then
        return "<Tab>"
    end
end, { desc = "Goto/Apply Next Edit Suggestion" })

vim.keymap.set("n", "<c-.>", function()
    ensure_sidekick()
    require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle" })

vim.keymap.set("n", "<leader>aa", function()
    ensure_sidekick()
    require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle CLI" })

vim.keymap.set("n", "<leader>as", function()
    ensure_sidekick()
    require("sidekick.cli").select()
end, { desc = "Select CLI" })

vim.keymap.set("n", "<leader>ad", function()
    ensure_sidekick()
    require("sidekick.cli").close()
end, { desc = "Detach a CLI Session" })

vim.keymap.set({ "x", "n" }, "<leader>at", function()
    ensure_sidekick()
    require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Send This" })

vim.keymap.set("n", "<leader>af", function()
    ensure_sidekick()
    require("sidekick.cli").send({ msg = "{file}" })
end, { desc = "Send File" })

vim.keymap.set("x", "<leader>av", function()
    ensure_sidekick()
    require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Send Visual Selection" })

vim.keymap.set({ "x", "n" }, "<leader>ap", function()
    ensure_sidekick()
    require("sidekick.cli").prompt({
        prompts = { hello = "world" },
    })
end, { desc = "Sidekick Select Prompt" })

vim.keymap.set("n", "<leader>ac", function()
    ensure_sidekick()
    require("sidekick.cli").toggle({ name = "opencode", focus = true })
end, { desc = "Sidekick Toggle Opencode" })

-- Copilot insert mode keymaps (these auto-load copilot on first use)
vim.keymap.set("i", "<right>", function()
    ensure_copilot()
    require("copilot.suggestion").accept()
end, { desc = "Accept Copilot suggestion" })

vim.keymap.set("i", "<up>", function()
    ensure_copilot()
    require("copilot.suggestion").next()
end, { desc = "Next Copilot Suggestion" })

vim.keymap.set("i", "<down>", function()
    ensure_copilot()
    require("copilot.suggestion").prev()
end, { desc = "Prev Copilot Suggestion" })
