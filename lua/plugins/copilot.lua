return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = "<C-l>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      vim.keymap.set("i", "<C-h>", "<C-o>u", { desc = "Undo Copilot accept" })
    end,
  },
  { "giuxtaposition/blink-cmp-copilot" },
}
