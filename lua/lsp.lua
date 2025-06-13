-- [[ Built-in LSP Configuration ]]
-- Minimal LSP setup using only Neovim's built-in LSP client
-- Plugin-compatible and easily extensible

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic signs
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================================================
-- LSP KEYMAPS
-- ============================================================================

-- LSP keymaps (set when LSP attaches to buffer)
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  
  -- Information
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  
  -- Actions
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  
  -- Diagnostics
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic quickfix" }))
  
  -- Workspace
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
end

-- ============================================================================
-- LSP CAPABILITIES
-- ============================================================================

-- Default capabilities for LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable completion capabilities
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- ============================================================================
-- SERVER SETUP HELPER
-- ============================================================================

-- Helper function to start LSP servers
-- This function can be used to manually start servers or by plugins
local function setup_server(server_name, config)
  config = config or {}
  config.on_attach = config.on_attach or on_attach
  config.capabilities = config.capabilities or capabilities
  
  -- Try to start the server if executable exists
  if vim.fn.executable(server_name) == 1 then
    vim.lsp.start({
      name = server_name,
      cmd = { server_name },
      root_dir = vim.fs.dirname(vim.fs.find({'.git', 'package.json', 'Cargo.toml', 'pyproject.toml', 'go.mod'}, { upward = true })[1]),
      on_attach = config.on_attach,
      capabilities = config.capabilities,
    })
  end
end

-- ============================================================================
-- AUTO-START COMMON SERVERS
-- ============================================================================

-- Auto-start LSP servers if they're installed
-- These are common servers that can be installed via package managers
local common_servers = {
  -- Language servers that might be globally installed
  "lua-language-server",  -- Lua
  "typescript-language-server", -- TypeScript/JavaScript  
  "pyright",             -- Python
  "rust-analyzer",       -- Rust
  "gopls",              -- Go
  "clangd",             -- C/C++
}

-- Create autocmd to start LSP servers for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lsp_autostart", { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    local filetype = vim.bo[bufnr].filetype
    
    -- Simple filetype to server mapping
    local server_map = {
      lua = "lua-language-server",
      typescript = "typescript-language-server", 
      javascript = "typescript-language-server",
      python = "pyright",
      rust = "rust-analyzer",
      go = "gopls",
      c = "clangd",
      cpp = "clangd",
    }
    
    local server = server_map[filetype]
    if server then
      setup_server(server)
    end
  end,
})

-- ============================================================================
-- EXPORTS
-- ============================================================================

-- Export functions for use by plugins or manual configuration
return {
  on_attach = on_attach,
  capabilities = capabilities,
  setup_server = setup_server,
}
