return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ timeout_ms = 3000 }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
    {
      "<leader>cF",
      function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      -- Optionally, use eslint_d first, then prettier as fallback:
      -- javascript = { "eslint_d", "prettierd" },
      -- typescript = { "eslint_d", "prettierd" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
