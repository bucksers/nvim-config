-- lua/config/lsp/typescript.lua
local M = {}

-- vtsls settings
local vtsls_opts = {
  filetypes = {
    "javascript","javascriptreact","javascript.jsx",
    "typescript","typescriptreact","typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk       = true,
      experimental               = {
        maxInlayHintLength = 30,
        completion         = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest                = { completeFunctionCalls = true },
      inlayHints             = {
        enumMemberValues         = { enabled = true  },
        functionLikeReturnTypes  = { enabled = true  },
        parameterNames           = { enabled = "literals" },
        parameterTypes           = { enabled = true  },
        propertyDeclarationTypes = { enabled = true  },
        variableTypes            = { enabled = false },
      },
    },
  },
}

------------------------------------------------------------------
-- extra keymaps for TS buffers
------------------------------------------------------------------
local function ts_maps(buf)
  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
  end

  -- source / file navigation
  map("gD", function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf.execute_command({
      command   = "typescript.goToSourceDefinition",
      arguments = { params.textDocument.uri, params.position },
    })
  end, "Goto Source Definition")

  map("gR", function()
    vim.lsp.buf.execute_command({
      command   = "typescript.findAllFileReferences",
      arguments = { vim.uri_from_bufnr(0) },
    })
  end, "File References")

  -- code-actions
  local function ca(kind) -- helper
    vim.lsp.buf.code_action({ context = { only = { kind } } })
  end
  map("<leader>co", function() ca("source.organizeImports.ts") end, "Organize Imports")
  map("<leader>cM", function() ca("source.addMissingImports.ts") end, "Add Missing Imports")
  map("<leader>cu", function() ca("source.removeUnused.ts")   end, "Remove Unused Imports")
  map("<leader>cD", function() ca("source.fixAll.ts")         end, "Fix All Diagnostics")

  -- select TS version
  map("<leader>cV", function()
    vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
  end, "Select TS Workspace Version")
end

------------------------------------------------------------------
-- optional "Move to File" refactor (port of LazyVim logic)
------------------------------------------------------------------
local function attach_move_to_file(client)
  client.commands["_typescript.moveToFileRefactoring"] = function(command)
    local action, uri, range = unpack(command.arguments)
    local function move(newf)
      client.request("workspace/executeCommand", {
        command   = command.command,
        arguments = { action, uri, range, newf },
      })
    end

    local fname = vim.uri_to_fname(uri)
    client.request("workspace/executeCommand", {
      command   = "typescript.tsserverRequest",
      arguments = {
        "getMoveToRefactoringFileSuggestions",
        {
          file        = fname,
          startLine   = range.start.line + 1,
          startOffset = range.start.character + 1,
          endLine     = range["end"].line + 1,
          endOffset   = range["end"].character + 1,
        },
      },
    }, function(_, result)
      local files = result.body.files
      table.insert(files, 1, "Enter new path...")
      vim.ui.select(files, {
        prompt      = "Select move destination:",
        format_item = function(f) return vim.fn.fnamemodify(f, ":~:.") end,
      }, function(f)
        if not f then return end
        if f:find("^Enter new path") then
          vim.ui.input({
            prompt   = "Enter move destination:",
            default  = vim.fn.fnamemodify(fname, ":h") .. "/",
            completion = "file",
          }, function(newf) if newf then move(newf) end end)
        else
          move(f)
        end
      end)
    end)
  end
end

------------------------------------------------------------------
-- public setup
------------------------------------------------------------------
function M.setup(cfg)
  local lspconfig   = require("lspconfig")
  local mason_lsp   = require("mason-lspconfig")

  -- ensure vtsls via mason
  mason_lsp.setup({ ensure_installed = { "vtsls" }, automatic_installation = true })

  -- disable tsserver globally by telling your generic loop to skip it
  if cfg.skip then cfg.skip.tsserver = true end

  lspconfig.vtsls.setup(vim.tbl_deep_extend("force", vtsls_opts, {
    on_attach = function(client, buf)
      cfg.on_attach(client, buf)
      ts_maps(buf)
      attach_move_to_file(client)
    end,
    capabilities = cfg.capabilities,
  }))
end

return M
