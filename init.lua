-- Plain Neovim Configuration
-- Minimal setup with modular structure

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load configuration modules
require('config/options')
require('config/lazy-bootstrap')
require('config/lazy')
require('config/keymaps')
require('config/autocmds')
require('config/lsp')
