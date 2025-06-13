return {
  "folke/tokyonight.nvim",
  lazy = false,    -- Load during startup
  priority = 1000, -- Load before other plugins
  config = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}
