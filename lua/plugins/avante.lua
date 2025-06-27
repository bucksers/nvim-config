return {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  version = false,

  opts = {
    --------------------------------------------------------------------
    -- 1. PRIMARY CHAT / EDIT PROVIDER
    --    Copilot handles inline completion; Avante chat still goes
    --    through Copilot’s GPT-4-o-based endpoint.
    --------------------------------------------------------------------
    provider = "copilot",
    -- omit `model` (Copilot picks its own; leaving a Claude name here
    -- would be ignored anyway)
    auto_suggestions = false,

    --------------------------------------------------------------------
    -- 2. WEB SEARCH
    --------------------------------------------------------------------
    web_search_engine = { provider = "google" },

    --------------------------------------------------------------------
    -- 3. RAG SERVICE (Docker runner)
    --------------------------------------------------------------------
    rag_service = {
      enabled    = true,
      runner     = "docker",
      -- Mount just this repo read-only; change to os.getenv("HOME")
      -- if you want whole-home indexing.
      host_mount = vim.loop.cwd(),

      -- 3-a: Generator model used *after* retrieval
      llm = {
        provider = "gemini",
        endpoint = "https://generativelanguage.googleapis.com/v1beta",
        api_key  = "GEMINI_API_KEY",      -- export this in your shell
        model    = "gemini-2.5-pro",
        extra    = nil,
      },

      -- 3-b: Embedding model that builds / queries the vector index
      embed = {
        provider = "gemini",
        endpoint = "https://generativelanguage.googleapis.com/v1beta",
        api_key  = "GEMINI_API_KEY",
        model    = "text-embedding-004",
        extra    = nil,
      },

      -- Extra docker flags if you need a proxy or custom network
      docker_extra_args = "",            -- e.g. "--pull=always"
    },

    --------------------------------------------------------------------
    -- 4. MCP INTEGRATION
    --------------------------------------------------------------------
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    disabled_tools = {
      "list_files", "search_files", "read_file", "create_file",
      "rename_file", "delete_file", "create_dir", "rename_dir",
      "delete_dir", "bash",
    },
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua",                          -- inline AI
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft   = { "markdown", "Avante" },
      opts = { file_types = { "markdown", "Avante" } },
    },
  },
}
