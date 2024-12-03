
-- Initialize packer.nvim for plugin management
require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- LSP configuration and management
  use { 'neovim/nvim-lspconfig', config = function()
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup{}
      lspconfig.ts_ls.setup{}
      lspconfig.sqlls.setup{}  -- SQL Language Server
  end }

  -- File explorer with icons
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = function()
      require'nvim-tree'.setup{}
  end }

-- AI-assisted coding with GitHub Copilot
-- Copilot key mapping
  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
  use { 'github/copilot.vim' }

-- Syntax highlighting with Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Discord presence
  use 'andweeb/presence.nvim'

  -- Auto-pairs for brackets and quotes
  use { 'windwp/nvim-autopairs', config = function()
      require('nvim-autopairs').setup{}
  end }

  -- Autocompletion plugin
  use 'hrsh7th/nvim-compe'

  -- Commenting utility
  use 'tpope/vim-commentary'

  -- Indentation guides
  use { 'lukas-reineke/indent-blankline.nvim', config = function()
      require("ibl").setup()
  end }

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Fuzzy finder
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Optional: Database client within Neovim
  use { 'tpope/vim-dadbod', config = function()
      vim.g.db_ui_auto_execute_table_helpers = 1
  end }

  use 'kristijanhusak/vim-dadbod-ui'  -- UI for vim-dadbod
  use 'kristijanhusak/vim-dadbod-completion'  -- Completion for vim-dadbod
end)

-- Basic Vim settings
vim.cmd [[
  colorscheme elflord
  set number
  set relativenumber
  set clipboard=unnamedplus
  highlight Pmenu guibg=#2e3440 guifg=white
  highlight PmenuSel guibg=#5e81ac guifg=white
  highlight LineNr guifg=#a3be8c guibg=NONE
  highlight CursorLineNr guifg=#ebcb8b guibg=NONE
]]

-- Custom function to run code based on file type
function run_code()
  local runners = {
    python = 'python3 %',
    r = 'Rscript %',
    sql = 'sqlite3 %',  -- Assuming SQLite, replace with the appropriate command for your DBMS
    html = 'open %',
    css = 'open %',
    javascript = 'open %'
  }
  local cmd = runners[vim.bo.filetype]
  if cmd then
    vim.cmd('!' .. cmd)
  else
    print("File type not supported")
  end
end

-- Key mappings
local key_mappings = {
  { 'n', '<C-n>', ':NvimTreeToggle<CR>' },
  { 'n', 'grr', [[<Cmd>lua run_code()<CR>]] },  -- Set to "grr" to run the current file
  { 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>' },
  { 'n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>' },
  { 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>' },
  { 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>' },
  { 'n', '<Leader>f', '<Cmd>Telescope find_files<CR>' }
}

for _, map in ipairs(key_mappings) do
  vim.api.nvim_set_keymap(map[1], map[2], map[3], { noremap = true, silent = true })
end

-- Configure icons
require'nvim-web-devicons'.setup {
  override = {
    python = {
      icon = "🐍",
      color = "#FFD43B",
      name = "Python"
    }
  },
  default = true,
}

-- Configure autocompletion (nvim-compe)
require'compe'.setup {
  enabled = false;
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

-- Add command to easily open terminal with :T
vim.api.nvim_create_user_command('T', 'terminal <args>', { nargs = '*' })
