-- lua/plugins/lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          -- you can also tweak separators here if you like
          -- section_separators = "", component_separators = "",
        },

        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          -- 🔍  FULL-PATH filename component
          lualine_c = { { "filename", path = 1 } },

          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },

        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
