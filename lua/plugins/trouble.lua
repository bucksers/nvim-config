-- lua/plugins/trouble.lua
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    -- extra from LazyVim: open the LSP mode on the right
    modes = {
      lsp = { win = { position = "right" } },
    },
  },
  keys = {
    -- diagnostics
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                         desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },

    -- loclist & quickfix
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    {
      "<leader>xl",
      function()
        local Trouble = require("trouble")
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = cursor[1] - 1

        local diags = vim.diagnostic.get(0, { lnum = line })
        if vim.tbl_isempty(diags) then
          vim.notify("No diagnostics on this line", vim.log.levels.INFO)
          return
        end

        Trouble.open({
          mode = "diagnostics",
          win = { position = "bottom" },
          focus = true,
          filter = {
            buf = 0,
            range = {
              start = { line = line },
              finish = { line = line },
            },
          },
        })
      end,
      desc = "Trouble – diagnostics for current line",
    },
    -- navigation keys borrowed from LazyVim
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then vim.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = "Previous Trouble/Quickfix Item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then vim.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = "Next Trouble/Quickfix Item",
    },
  },
}
