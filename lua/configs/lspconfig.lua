-- local lspconfig = require("nvchad.configs.lspconfig").defaults()
-- -- local servers = { "html", "cssls" }
-- -- vim.lsp.enable(servers)
--
-- local config = {
--   virtual_text = {
--     source = false, -- Don't show source (like "tsserver")
--     format = function(diagnostic)
--       return diagnostic.message -- Just show the error message
--     end,
--   },
--   signs = true,
--   underline = true,
--   float = {
--     source = false, -- Don't show source in hover
--     format = function(diagnostic)
--       return diagnostic.message
--     end,
--   },
-- }
--
-- vim.diagnostic.config(config)
--
-- vim.keymap.set("n", "<leader>e", function()
--   vim.diagnostic.open_float(nil, { focus = false })
-- end, { desc = "Show line diagnostics" })
--
-- local formatter_logger = require "configs.formatter-logger"
-- formatter_logger.setup_formatter_notifications()
--
-- vim.keymap.set("n", "<leader>fi", function()
--   formatter_logger.show_active_formatters()
-- end, { desc = "Show active formatters" })
--
-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   settings = {
--     gopls = {
--       gofumpt = true, -- Use gofumpt instead of gofmt
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--         unreachable = true,
--         fillstruct = true,
--       },
--       staticcheck = true,
--       codelenses = {
--         gc_details = true,
--         generate = true,
--         regenerate_cgo = true,
--         tidy = true,
--         upgrade_dependency = true,
--         vendor = true,
--       },
--     },
--   },
-- }
-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()

-- Get the required LSP configuration functions
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- Simple diagnostic configuration
local config = {
  virtual_text = {
    source = false, -- Don't show source (like "tsserver")
    format = function(diagnostic)
      return diagnostic.message -- Just show the error message
    end,
  },
  signs = true,
  underline = true,
  float = {
    source = false, -- Don't show source in hover
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}

vim.diagnostic.config(config)

-- Show line diagnostics keybind
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show line diagnostics" })

-- Formatter logger setup
local formatter_logger = require "configs.formatter-logger"
formatter_logger.setup_formatter_notifications()

vim.keymap.set("n", "<leader>fi", function()
  formatter_logger.show_active_formatters()
end, { desc = "Show active formatters" })

-- TypeScript Language Server
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- Disable ts_ls formatting to let Biome handle it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
}

-- Biome Language Server
lspconfig.biome.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- ESLint Language Server
lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- Auto-fix ESLint issues on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("ESLintFixAll", { clear = true }),
      callback = function()
        if client.name == "eslint" then
          vim.lsp.buf.code_action {
            context = {
              -- only = { "source.fixAll.eslint" },
              only = { "source.fixAll" },
              diagnostics = {},
            },
            apply = true,
          }
        end
      end,
    })
  end,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    workingDirectories = { mode = "auto" },
  },
}

-- Go Language Server
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true, -- Use gofumpt instead of gofmt
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
        fillstruct = true,
      },
      staticcheck = true,
      codelenses = {
        gc_details = true,
        generate = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
}

-- HTML and CSS Language Servers
local servers = { "html", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Enhanced LSP Saga keybindings
local function setup_lspsaga_keymaps()
  local opts = { noremap = true, silent = true }

  -- Hover and signature help
  vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
  vim.keymap.set("n", "<leader>K", ":Lspsaga signature_help<CR>", opts)

  -- Navigation
  vim.keymap.set("n", "gf", ":Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "gp", ":Lspsaga peek_definition<CR>", opts)
  vim.keymap.set("n", "gt", ":Lspsaga peek_type_definition<CR>", opts)
  vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)

  -- Code actions
  vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
  vim.keymap.set("x", "<leader>ca", ":<c-u>Lspsaga range_code_action<CR>", opts)

  -- Diagnostics
  vim.keymap.set("n", "<leader>d", ":Lspsaga show_line_diagnostics<CR>", opts)
  vim.keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)

  -- Rename
  vim.keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", opts)

  -- Outline
  vim.keymap.set("n", "<leader>o", ":Lspsaga outline<CR>", opts)
end

-- Setup LSP Saga keymaps
setup_lspsaga_keymaps()

-- Debug commands
vim.api.nvim_create_user_command("ConformInfo", function()
  require("conform").info()
end, {})

vim.api.nvim_create_user_command("ConformLog", function()
  vim.cmd("edit " .. vim.fn.stdpath "log" .. "/conform.log")
end, {})
