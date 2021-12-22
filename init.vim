syntax on

let mapleader = ' '
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

inoremap jk <Esc>
inoremap jj <Esc> 
inoremap kj <Esc>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-s> :w<CR>


nnoremap <leader>x :bp<cr>:bd #<cr> 
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

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
