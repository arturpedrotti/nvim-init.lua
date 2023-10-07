-- Initialize packer.nvim for plugin management
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'Exafunction/codeium.vim'
  use {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd('TSUpdate') end}
  use 'andweeb/presence.nvim'
  use 'windwp/nvim-autopairs' -- Auto close pairs, useful for HTML tags
  use 'hrsh7th/nvim-compe'   -- Autocompletion plugin
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

-- Custom function to run code
function run_code()
  local filetype = vim.bo.filetype

  if filetype == 'python' then
    vim.cmd('!python3 %')
  elseif filetype == 'html' or filetype == 'css' or filetype == 'javascript' then
    vim.cmd('!open %') -- replace this with the actual command to run HTML, CSS or JS files
  else
    print("File type not supported")
  end
end
-- Updated key mapping
vim.api.nvim_set_keymap('n', '<A-CR>', [[<Cmd>lua run_code()<CR>]], { noremap = true, silent = false })

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

-- Configure icons
require'nvim-web-devicons'.setup {
  override = {
    python = {
      icon = "🐍",
      color = "#FFD43B",
      name = "Python"
    }
  };
  default = true;
}

-- Configure nvim-autopairs
require('nvim-autopairs').setup{}

-- Configure nvim-compe for autocompletion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

