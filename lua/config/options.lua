-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable gray highlighting for unused/unnecessary code from LSP diagnostics
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "NONE", bg = "NONE" })
    end)
  end,
})
