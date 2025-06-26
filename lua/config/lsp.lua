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
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
end

-- LSP capabilities for blink.cmp
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Minimal LSP setup using mason-lspconfig
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  automatic_installation = true,
})

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Enable inlay hints (Neovim 0.10+)
if vim.lsp.inlay_hint then
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
  })
end
