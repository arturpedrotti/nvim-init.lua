-- Initialize packer.nvim for plugin management
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Native LSP enhancements
  use 'neovim/nvim-lspconfig'
  -- Tree viewer
  use 'kyazdani42/nvim-tree.lua'
  -- Devicons
  use 'kyazdani42/nvim-web-devicons'
  -- codeium.vim
  use 'Exafunction/codeium.vim'
  -- Add nvim-treesitter
  use {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd('TSUpdate') end}
  -- Add presence.nvim
  use 'andweeb/presence.nvim'
end)

-- Vim settings
vim.cmd "colorscheme elflord"
vim.cmd 'set number'
vim.cmd 'set relativenumber'
vim.o.clipboard = "unnamedplus"

-- Setup LSP
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}

-- Tree viewer (nvim-tree.lua) configuration
require'nvim-tree'.setup {}

-- Key mappings for nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Run Python3 code with <Option-Enter> (or <Alt-Enter>) in normal mode
-- Executes the entire file
vim.api.nvim_set_keymap('n', '<A-CR>', [[<Cmd>!python3 %<CR>]], { noremap = true, silent = false })

-- Run selected Python3 code with <Option-Enter> (or <Alt-Enter>) in visual mode
-- Executes only the selected lines
vim.api.nvim_set_keymap('v', '<A-CR>', [[:w !python3<CR>]], { noremap = true, silent = false })

-- LSP keybindings
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

-- UI enhancements
vim.cmd [[
  highlight Pmenu guibg=#2e3440 guifg=white
  highlight PmenuSel guibg=#5e81ac guifg=white
  highlight LineNr guifg=#a3be8c guibg=NONE
  highlight CursorLineNr guifg=#ebcb8b guibg=NONE
]]

-- This is where you could configure icons, if your version of nvim-tree supports it.
require'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  override = {
    python = {
      icon = "🐍",
      color = "#FFD43B",
      name = "Python"
    }
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}


