--- lua/config/lsp/typescript.lua  (only key-maps, no LSP setup)
local M = {}

function M.setup()
  ---------------------------------------------------------------------------
  -- Buffer-local maps for TS / JS                                     🗺️
  ---------------------------------------------------------------------------
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "typescript",   "typescriptreact", "typescript.tsx",
      "javascript",   "javascriptreact", "javascript.jsx",
    },
    callback = function(ev)
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs,
          { buffer = ev.buf, silent = true, desc = desc })
      end

      local function ca(kind)      -- helper to trigger a filtered code-action
        vim.lsp.buf.code_action({ context = { only = { kind } } })
      end

      -- navigation ---------------------------------------------------------
      map("gD", vim.lsp.buf.declaration, "Go to Declaration")
      map("gR", vim.lsp.buf.references,  "Go to References")

      -- code actions -------------------------------------------------------
      map("<leader>co", function() ca("source.organizeImports.ts")  end,
          "Organize Imports")
      map("<leader>cM", function() ca("source.addMissingImports.ts") end,
          "Add Missing Imports")
      map("<leader>cu", function() ca("source.removeUnused.ts")     end,
          "Remove Unused Imports")
      map("<leader>cD", function() ca("source.fixAll.ts")           end,
          "Fix All Diagnostics")

      -- pick TypeScript version in workspace ------------------------------
      map("<leader>cV", function()
        vim.lsp.buf.execute_command({
          command   = "typescript.selectTypeScriptVersion",
        })
      end, "Select TS Workspace Version")
    end,
  })
end

return M
