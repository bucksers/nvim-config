return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = vim.g.snacks_icons and vim.g.snacks_icons.diagnostics or { Error = "E", Warn = "W" }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        get_element_icon = function(opts)
          if vim.g.snacks_icons and vim.g.snacks_icons.ft then
            return vim.g.snacks_icons.ft[opts.filetype]
          end
          -- fallback to nvim-web-devicons
          local icon, _ = require('nvim-web-devicons').get_icon_by_filetype(opts.filetype, { default = true })
          return icon
        end,
      },
    },
  },
}
