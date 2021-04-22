let mapleader = ' '

call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/jsonc.vim'
Plug 'lilydjwg/colorizer'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-surround'
call plug#end()

syntax on

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'

let g:go_def_mapping_enabled = 0

colorscheme gruvbox
set fileformat=unix
set background=dark
set termguicolors
set nohlsearch
set noshowmode
set noerrorbells
set relativenumber number
set encoding=UTF-8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set mouse=a
set noswapfile
set nobackup
set undofile
set incsearch 
set pastetoggle=<F2>
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set hidden 
set cmdheight=2
set updatetime=50
set shortmess+=c
set colorcolumn=80
set signcolumn=yes

"""""""""""""""
" misc keybinds
"""""""""""""""
inoremap jk <Esc>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-s> :w<CR>

nnoremap <C-_> :call NERDComment(1, 'toggle')<CR>

nnoremap <leader>x :bp<cr>:bd #<cr> 
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

nnoremap <leader>cc :call NERDComment(1, 'toggle')<CR>
nnoremap <leader>sf <cmd>lua vim.lsp.buf.formatting()<CR>

"""""""" TELESCOPE """"""""
nnoremap <leader>n :NvimTreeToggle<cr>
nnoremap <leader>tr :NvimTreeRefresh<cr>
nnoremap <leader>tf :NvimTreeFindFile<cr>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"""""""" LSP """""""""""
nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent>gD <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent>gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent>gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent>gh <cmd>lua vim.lsp.buf.signature_help()<cr>

nnoremap <silent>g{ <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent>g} <cmd>lua vim.lsp.diagnostic.goto_next()<cr>

nnoremap <silent>K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>ac <cmd>lua vim.lsp.buf.code_action()<cr>

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

lua << EOF
require('lualine').setup{
    options = {theme = 'gruvbox'},
    extenstions = {'nvim-tree'}
}

require('telescope').setup{
defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "$ ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua require('lspconfig').tsserver.setup{on_attach=require('completion').on_attach}
lua require('lspconfig').html.setup{on_attach=require('completion').on_attach}
lua require('lspconfig').cssls.setup{on_attach=require('completion').on_attach}
lua require('lspconfig').pyright.setup{on_attach=require('completion').on_attach}
lua require('lspconfig').jsonls.setup{on_attach=require('completion').on_attach}

autocmd BufEnter * lua require'completion'.on_attach()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" tsconfig.json
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point

if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
