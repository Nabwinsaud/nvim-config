local overrides = require("configs.overrides")

return {
  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = overrides.mason,
    config = function(_, opts)
      require("mason").setup(opts)
      vim.cmd([[autocmd User MasonToolsUpdateCompleted ++once lua vim.notify("Mason tools updated")]])
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup(overrides.treesitter)
    end,
  },

  -- Mason LSP Config
  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   dependencies = { 'williamboman/mason.nvim' },
  --   config = function()
  --     local lspconfig = require('lspconfig')
  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  --
  --     require('mason-lspconfig').setup({
  --       ensure_installed = overrides.lspconfig.ensure_installed,
  --       automatic_installation = true,
  --     })
  --
  --     require('mason-lspconfig').setup_handlers {
  --       function(server_name)
  --         lspconfig[server_name].setup {
  --           capabilities = capabilities,
  --           on_attach = function(client, bufnr)
  --             -- Optional: add your on_attach logic here
  --           end,
  --         }
  --       end,
  --     }
  --   end,
  -- },
{
  'williamboman/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'williamboman/mason.nvim' },
  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local overrides = require('configs.overrides')
    local defaults = require("nvchad.configs.lspconfig").defaults

    mason_lspconfig.setup({
      ensure_installed = overrides.lspconfig.ensure_installed,
      automatic_installation = true,
    })

    -- Loop over installed servers
    for _, server_name in ipairs(overrides.lspconfig.ensure_installed) do
      lspconfig[server_name].setup {
        on_attach = defaults.on_attach,
        capabilities = defaults.capabilities,
      }
    end
  end,
},
  -- LSP Config loader
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('configs.lspconfig')
    end,
  },

  -- Formatter
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
      require('conform').setup(require('configs.conform'))
    end,
  },
  -- escape key combo 
{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		lazy = false,
	},
}

