require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local function setup_enhanced_lsp_keymaps()
  local opts = { noremap = true, silent = true }

  -- Use LSP Saga for hover (more beautiful than default)
  vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
  vim.keymap.set("n", "<leader>K", ":Lspsaga signature_help<CR>", opts)

  -- Other LSP Saga commands
  vim.keymap.set("n", "gd", ":Lspsaga peek_definition<CR>", opts)
  vim.keymap.set("n", "gf", ":Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
  vim.keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", opts)
  vim.keymap.set("n", "<leader>d", ":Lspsaga show_line_diagnostics<CR>", opts)
  vim.keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
end

setup_enhanced_lsp_keymaps()
