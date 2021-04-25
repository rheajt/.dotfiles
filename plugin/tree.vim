let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_side = 'right'
let g:nvim_tree_width = 40
let g:nvim_tree_follow = 1
let g:nvim_tree_auto_close = 1

nnoremap <leader>n :NvimTreeToggle<cr>
nnoremap <leader>tr :NvimTreeRefresh<cr>
nnoremap <leader>tf :NvimTreeFindFile<cr>


