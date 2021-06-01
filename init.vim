call plug#begin('~/.config/nvim/plugged')
" TELESCOPE
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" LUALINE
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" NVIM TREE
Plug 'kyazdani42/nvim-tree.lua'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" THEME
Plug 'gruvbox-community/gruvbox'

" MISC
Plug 'windwp/nvim-autopairs'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/jsonc.vim'
Plug 'lilydjwg/colorizer'
Plug 'tpope/vim-surround'
call plug#end()

syntax on
colorscheme gruvbox

let mapleader = ' '
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'
let g:go_def_mapping_enabled = 0

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
set autoindent
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


nnoremap <leader>x :bp<cr>:bd #<cr> 
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

nnoremap <C-_> :call NERDComment(1, 'toggle')<CR>
"nnoremap <leader>cc :call NERDComment(1, 'toggle')<CR>


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
