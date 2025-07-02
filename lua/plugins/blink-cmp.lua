return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets"
    },
    version = "1.*",
    opts = {
      keymap = {
        preset = "super-tab",

        -- Disable the default mapping for C-space
        ['<C-space>'] = {}, 

        -- move <C-space> actions to <C-y>
         ['<C-y>'] = { 'show', 'show_documentation', 'hide_documentation' }, 
      },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      enabled = function()
        local ft = vim.bo.filetype
        -- Avante uses AvanteInput (prompt), Avante (sidebar / chat),
        -- and AvanteEdit (edit-diff buffer)
        return not ft:match("^Avante")
      end,
    },
    opts_extend = { "sources.default" },
  },
}
