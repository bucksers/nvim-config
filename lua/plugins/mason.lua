-- lua/plugins/mason.lua
return {
  { "williamboman/mason.nvim", config = true },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",

    config = function()
      local skipped = { vtsls = true, ts_ls = true, tsserver = true }

      require("mason-lspconfig").setup({
        -- Mason may still download them, but won’t auto-install any in `skipped`
        automatic_installation = { exclude = vim.tbl_keys(skipped) },

        -- Handler table – run ONLY when the server is NOT skipped
        handlers = {
          function(server)
            if not skipped[server] then
              require("lspconfig")[server].setup({})
            end
          end,
        },
      })
    end,
  },
}
