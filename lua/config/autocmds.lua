-- [[ Basic Autocommands ]]
-- Core Neovim autocommands for better user experience

-- Helper function to create augroups
local function augroup(name)
  return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end

-- ============================================================================
-- FILE HANDLING
-- ============================================================================

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- autosave on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
  group = augroup("autosave_focuslost"),
  callback = function()
    -- Silently write all modifiable, modified buffers when Neovim loses focus
    vim.cmd("silent! wa")
  end,
  desc = "Autosave all files on focus lost",
})

-- Go to last cursor position when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ============================================================================
-- VISUAL FEEDBACK
-- ============================================================================

-- Keep yellow squiggle for “unused” diagnostics
-- but prevent the text from turning grey
local function fix_unused_hl()
  -- Link the group to Normal; the "!" forces override even if it exists
  vim.cmd("highlight! link DiagnosticUnnecessary Normal")
end

-- Apply immediately (covers startup diagnostics)
fix_unused_hl()

-- Re-apply if you change colourschemes or when diagnostics update
local grey_grp = vim.api.nvim_create_augroup("FixDiagnosticGrey", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "DiagnosticChanged" }, {
  group = grey_grp,
  callback = fix_unused_hl,
})

-- Highlight yanked text (uses the new vim.hl API, not deprecated)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})


-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ============================================================================
-- FILETYPE SPECIFIC SETTINGS
-- ============================================================================

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Make man pages easier to close
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Enable wrap and spell for text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
-- ~/.config/nvim/lua/avante_disable_popup.lua  (or anywhere that is sourced)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "AvanteInput",
  callback = function()
    vim.b.blink_cmp_enabled = false
  end,
})
