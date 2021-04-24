let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_side = 'right'
let g:nvim_width = 40

nnoremap <leader>n :NvimTreeToggle<cr>
nnoremap <leader>tr :NvimTreeRefresh<cr>
nnoremap <leader>tf :NvimTreeFindFile<cr>

"lua require'nvim-treesitter.configs'.setup{highlight = {enable = true}}
