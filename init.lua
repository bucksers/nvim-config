-- Plain Neovim Configuration
-- Minimal setup with modular structure

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load options, keymaps, autocommands, and LSP
require('options')
require('keymaps')
require('autocmds')
require('lsp')
