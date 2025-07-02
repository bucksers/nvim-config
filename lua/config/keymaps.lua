-- Enhance command-line completion
vim.cmd([[
  cnoremap <Tab>   wildmenumode() ? '\<C-n>' : '\<Tab>'
  cnoremap <S-Tab> wildmenumode() ? '\<C-p>' : '\<S-Tab>'
]])
-- [[ Basic Keymaps ]]
-- Core Neovim keymaps that appear in multiple popular configurations
-- All keymaps use desc, so which-key will automatically show them.

-- ============================================================================
-- SEARCH & HIGHLIGHTING
-- ============================================================================

-- Clear search highlights on escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- ============================================================================
-- WINDOW NAVIGATION
-- ============================================================================

-- Move to window using Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- ============================================================================
-- DIAGNOSTICS & QUICKFIX
-- ============================================================================

-- Open diagnostic quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- ============================================================================
-- EDITING ENHANCEMENTS
-- ============================================================================

-- Better indenting - stay in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })


-- ============================================================================
-- SYSTEM CLIPBOARD YANKING AND PASTING (pasting with auto-indent)
-- ============================================================================

-- Normal mode: <leader>y to yank to system clipboard (like "y" but to +)
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to clipboard' })

-- Yank entire file to system clipboard
vim.keymap.set('n', '<leader>Y', ':%yank +<CR>', { desc = 'Yank entire file to clipboard' })

-- Visual mode: <leader>y to yank selection to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to clipboard' })

-- (Optional) Operator-pending mode (for text objects, e.g., <leader>yiw)
vim.keymap.set('o', '<leader>y', '"+y', { desc = 'Yank to clipboard (operator)' })

-- Normal mode: <leader>p and <leader>P paste from clipboard and re-indent
vim.keymap.set('n', '<leader>p', '"+p`[v`]=', { desc = 'Paste after (clipboard, auto-indent)' })

-- Visual mode: <leader>p and <leader>P paste over selection from clipboard and re-indent
vim.keymap.set('v', '<leader>p', '"+p`[v`]=', { desc = 'Paste over (clipboard, auto-indent)' })


-- ============================================================================
-- WINDOW RESIZING
-- ============================================================================

-- Resize window using Ctrl + arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })
