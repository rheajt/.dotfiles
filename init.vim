call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/jsonc.vim'
Plug 'lilydjwg/colorizer'
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
call plug#end()

syntax on

let mapleader = ' '
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'

colorscheme gruvbox
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
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch 
set pastetoggle=<F2>
set scrolloff=5
set noshowmode
set completeopt=menuone,noinsert,noselect
set hidden 
set cmdheight=2
set updatetime=50
set shortmess+=c
set colorcolumn=80
set signcolumn=yes

""""
"netrw
""""
let g:netrw_liststyle = 0
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_altv = 1

nnoremap <silent> <C-n> :Lex<CR>
nnoremap <silent> <leader>nh :wincmd h<CR> :q<CR>
nnoremap <silent> <leader>nj :wincmd j<CR> :q<CR>
nnoremap <silent> <leader>nk :wincmd k<CR> :q<CR>
nnoremap <silent> <leader>nl :wincmd l<CR> :q<CR>

""""
" misc keybinds
""""
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


nnoremap <silent><leader>cc :call NERDComment(1, 'toggle')<CR>

nmap <silent> <C-P> :GFiles<CR>
nmap <leader>b :Buff<CR>
nmap <silent> <C-F> :Rg<CR>

let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'batcat -p --color always {}']}, <bang>0)

"""""
" CoC
"""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gd :call CocAction('jumpDefinition')<CR>
"nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gy :call CocAction('jumpTypeDefinition')<CR>
"nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gi :call CocAction('jumpImplementation')<CR>
"nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gr :call CocAction('jumpReferences')<CR>

nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup format_group
  autocmd!
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" tsconfig.json
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" lightline
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
    \   'filename': 'LightlineFilename',
	\ },
	\ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

