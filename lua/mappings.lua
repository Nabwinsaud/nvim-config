require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end)

local function setup_enhanced_lsp_keymaps()
  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
  vim.keymap.set("n", "<leader>K", ":Lspsaga signature_help<CR>", opts)

  -- vim.keymap.set("n", "gd", ":Lspsaga peek_definition<CR>", opts)
  vim.keymap.set("n", "gf", ":Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
  vim.keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", opts)
  vim.keymap.set("n", "<leader>d", ":Lspsaga show_line_diagnostics<CR>", opts)
  vim.keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
end

setup_enhanced_lsp_keymaps()

-- Keymaps for navigating and managing TODO comments
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
vim.keymap.set("n", "<leader>fq", "<cmd>TodoQuickFix<cr>", { desc = "Find todos (quickfix)" })
vim.keymap.set("n", "<leader>fl", "<cmd>TodoLocList<cr>", { desc = "Find todos (loclist)" })
