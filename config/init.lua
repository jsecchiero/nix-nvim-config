-- Set NVIM_APPNAME to `nvim` if it is not set
if vim.env.NVIM_APPNAME == nil then
  vim.env.NVIM_APPNAME = 'nvim'
end

-- Set the runtime path to include `nvim` configuration files
if vim.g.config_root ~= nil then
  package.path = vim.g.config_root .. '/lua/?.lua;'
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
require('lazy-bootstrap')

-- [[ Configure plugins ]]
require('lazy-plugins')

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require('keymaps')

-- [[ Configure Telescope ]]
-- (fuzzy finder)
require('telescope-setup')

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require('treesitter-setup')

-- [[ Configure LSP ]]
-- (Language Server Protocol)
require('lsp-setup')

-- [[ Configure nvim-cmp ]]
-- (completion)
require('cmp-setup')

-- [[ Configure nvim-dap ]]
-- (debugging)
require('dap-setup')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
