-- [[ Built-in LSP Configuration ]]
-- Minimal LSP setup using Neovim's built-in LSP client
-- Plugin-compatible and easily extensible
---------------------------------------------------------------------
-- DIAGNOSTIC CONFIGURATION
---------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source  = "if_many",
    prefix  = "●",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN]  = "󰀪 ",
      [vim.diagnostic.severity.HINT]  = "󰌶 ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
  },
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float = {
    focusable = false,
    style     = "minimal",
    border    = "rounded",
    source    = "always",
    header    = "",
    prefix    = "",
  },
})

---------------------------------------------------------------------
-- LSP KEYMAPS
---------------------------------------------------------------------
local function on_attach(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "K",       vim.lsp.buf.hover,          vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  vim.keymap.set("n", "<C-k>",   vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  vim.keymap.set("n", "[d",      vim.diagnostic.goto_prev,   vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  vim.keymap.set("n", "]d",      vim.diagnostic.goto_next,   vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
end

---------------------------------------------------------------------
-- CAPABILITIES (blink.cmp)
---------------------------------------------------------------------
local capabilities = require("blink.cmp").get_lsp_capabilities() 

---------------------------------------------------------------------
-- SERVER SETUP 
---------------------------------------------------------------------
local lspconfig       = require("lspconfig")

---------------------------------------------------------------------
-- INLAY HINTS (Neovim 0.10+)
---------------------------------------------------------------------
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

---------------------------------------------------------------------
-- LANGUAGE-SPECIFIC EXTENSIONS
---------------------------------------------------------------------
require("config.lsp.typescript").setup {
  on_attach    = on_attach,
  capabilities = capabilities,
  skip         = skip,          -- pass skip list so TS module knows tsserver is off
}
