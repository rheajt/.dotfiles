vim.pack.add {
  {
    src = 'https://github.com/bojackduy/nvim-herdr-navigation.git',
    name = 'nvim-herdr-navigation',
  },
}

local herdr_plugin = vim.pack.get({ 'nvim-herdr-navigation' })[1]
vim.opt.rtp:prepend(herdr_plugin.path .. '/nvim-herdr-navigation')

vim.schedule(
  function()
    require('herdr-navigation').setup {
      keybindings = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
      },
    }
  end
)
