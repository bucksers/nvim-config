-- Plain Neovim Configuration
-- Minimal setup with modular structure

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load options and keymaps
require('options')
require('keymaps')
