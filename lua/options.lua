-- [[ Setting options ]]
-- Plain Neovim configuration with sensible defaults

-- ============================================================================
-- DISPLAY & UI
-- ============================================================================

-- Line numbers
vim.o.number = true              -- Show absolute line numbers
vim.o.relativenumber = true      -- Show relative line numbers

-- Visual enhancements
vim.o.cursorline = true          -- Highlight the current line
vim.o.signcolumn = 'yes'         -- Always show the sign column
vim.o.termguicolors = true       -- Enable 24-bit RGB colors
vim.o.showmode = false           -- Don't show mode in command line

-- Whitespace display
vim.o.list = true                -- Show invisible characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Line wrapping
vim.o.wrap = false               -- Don't wrap long lines
vim.o.linebreak = true           -- Wrap at word boundaries when enabled
vim.o.breakindent = true         -- Maintain indent when wrapping

-- Popup menu
vim.o.pumheight = 10             -- Maximum popup menu height

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================

-- Search behavior
vim.o.ignorecase = true          -- Ignore case in search patterns
vim.o.smartcase = true           -- Case-sensitive if uppercase letters used
vim.o.inccommand = 'split'       -- Live preview of substitutions

-- Scrolling
vim.o.scrolloff = 10             -- Keep lines visible above/below cursor
vim.o.sidescrolloff = 8          -- Keep columns visible left/right of cursor

-- ============================================================================
-- INDENTATION & FORMATTING
-- ============================================================================

-- Tab settings
vim.o.expandtab = true           -- Use spaces instead of tabs
vim.o.tabstop = 2                -- Number of spaces a tab represents
vim.o.shiftwidth = 2             -- Number of spaces for auto-indent
vim.o.smartindent = true         -- Smart auto-indenting
vim.o.shiftround = true          -- Round indent to multiple of shiftwidth

-- ============================================================================
-- FILE HANDLING
-- ============================================================================

-- Clipboard integration
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus' -- Use system clipboard
end)

-- File operations
vim.o.undofile = true            -- Enable persistent undo
vim.o.undolevels = 10000         -- Number of undo levels
vim.o.autowrite = true          -- Auto-save when switching buffers
vim.o.confirm = true             -- Confirm before closing unsaved files

-- ============================================================================
-- WINDOW & SPLIT BEHAVIOR
-- ============================================================================

-- Split directions
vim.o.splitright = true          -- Open vertical splits to the right
vim.o.splitbelow = true          -- Open horizontal splits below

-- Window sizing
vim.o.winminwidth = 5            -- Minimum window width

-- ============================================================================
-- INPUT & INTERACTION
-- ============================================================================

-- Mouse support
vim.o.mouse = 'a'                -- Enable mouse in all modes

-- Timing
vim.o.updatetime = 250           -- Faster completion and diagnostics
vim.o.timeoutlen = 300           -- Time to wait for mapped sequence

-- Command line completion
vim.o.wildmode = "longest:full,full" -- Better command completion

-- Completion behavior
vim.opt.completeopt = "menu,menuone,noselect"

-- Visual block mode
vim.o.virtualedit = "block"      -- Allow cursor beyond end of line in visual block

-- ============================================================================
-- LANGUAGE & LOCALE
-- ============================================================================

-- Spell checking
vim.opt.spelllang = { "en" }     -- Spell check language
