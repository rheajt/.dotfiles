"""""""" LSP """""""""""
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_trigger_character = ['.']

nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent>gD <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent>gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent>gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent>gh <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent>g{ <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent>g} <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <silent>K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>ac <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>gb <cmd>lua vim.lsp.buf.formatting()<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
autocmd BufEnter * lua require'completion'.on_attach()

lua << EOF
require('lspconfig').tsserver.setup{on_attach=require('completion').on_attach}
require('lspconfig').html.setup{on_attach=require('completion').on_attach}
require('lspconfig').cssls.setup{on_attach=require('completion').on_attach}
require('lspconfig').pyright.setup{on_attach=require('completion').on_attach}
require('lspconfig').jsonls.setup{on_attach=require('completion').on_attach}

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then    
  configs.emmet_ls = {    
    default_config = {    
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css'};
      root_dir = function(fname)    
        return vim.loop.cwd()
      end;    
      settings = {};    
    };    
  }    
end    
lspconfig.emmet_ls.setup{ capabilities = capabilities; }
EOF
