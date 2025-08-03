local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    -- Use only Prettier for formatting, let ESLint handle linting separately
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },

    -- Go formatters
    go = { "gofumpt", "goimports" },

    -- Other file types
    json = { "prettier" },
    jsonc = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
  },

  format_on_save = {
    -- Increased timeout for slower systems
    timeout_ms = 2000,
    -- Don't fall back to LSP formatting to avoid conflicts
    lsp_fallback = false,
    -- Run formatting asynchronously to prevent blocking
    async = true,
    -- Don't show notifications for successful formatting
    quiet = true,
  },

  -- Logging level to see which formatter is used
  log_level = vim.log.levels.INFO,
  notify_on_error = true,
  notify_no_formatters = true,

  formatters = {
    -- Go formatters
    goimports = {
      prepend_args = { "-local", "$(go list -m)" },
    },
    gofumpt = {
      prepend_args = { "-extra" },
    },
    
    -- Prettier configuration
    prettier = {
      command = "prettier",
      args = { "--stdin-filepath", "$FILENAME" },
      -- Only run Prettier if there's a config file
      condition = function(ctx)
        return vim.fs.find({
          ".prettierrc",
          ".prettierrc.js",
          ".prettierrc.json",
          "prettier.config.js",
        }, { path = ctx.filename, upward = true })[1] ~= nil
      end,
    },
    
    -- ESLint configuration (only for linting, not formatting)
    eslint_d = {
      -- Only run if eslint_d is available
      command = "eslint_d",
      -- Only run if there's an ESLint config file
      condition = function(ctx)
        return vim.fs.find({
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.json",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          "eslint.config.js",
          "eslint.config.mjs",
        }, { path = ctx.filename, upward = true })[1] ~= nil
      end,
    },
  },
}

return options
