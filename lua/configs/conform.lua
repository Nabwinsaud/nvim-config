-- local options = {
--   formatters_by_ft = {
--     lua = { "stylua" },
--
--     -- JavaScript/TypeScript with Biome as primary, ESLint as fallback
--     javascript = { "biome", "eslint_d" },
--     javascriptreact = { "biome", "eslint_d" },
--     typescript = { "biome", "eslint_d" },
--     typescriptreact = { "biome", "eslint_d" },
--
--     -- Go formatting
--     go = { "gofmt", "goimports" },
--
--     -- Other web formats
--     json = { "biome" },
--     jsonc = { "biome" },
--     css = { "biome" },
--     scss = { "biome" },
--     html = { "biome" },
--     markdown = { "biome" },
--   },
--
--   -- Enable format on save
--   format_on_save = {
--     timeout_ms = 500,
--     lsp_fallback = true,
--   },
--
--   -- Custom formatter configurations
--   formatters = {
--     biome = {
--       condition = function(ctx)
--         return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1]
--       end,
--     },
--     eslint_d = {
--       condition = function(ctx)
--         return vim.fs.find({
--           ".eslintrc.js",
--           ".eslintrc.json",
--           ".eslintrc.yaml",
--           ".eslintrc.yml",
--           "eslint.config.js",
--           "eslint.config.mjs",
--         }, { path = ctx.filename, upward = true })[1]
--       end,
--     },
--   },
-- }
--
-- return options
--
--
local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    -- JavaScript/TypeScript with Biome as primary, ESLint as fallback
    javascript = { "biome", "eslint_d" },
    javascriptreact = { "biome", "eslint_d" },
    typescript = { "biome", "eslint_d" },
    typescriptreact = { "biome", "eslint_d" },

    -- Go formatting (enhanced)
    go = { "goimports", "gofmt", "gofumpt" },

    -- Other web formats
    json = { "biome" },
    jsonc = { "biome" },
    css = { "biome" },
    scss = { "biome" },
    html = { "biome" },
    markdown = { "biome" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- Logging level to see which formatter is used
  log_level = vim.log.levels.INFO,
  notify_on_error = true,
  notify_no_formatters = true,

  formatters = {
    biome = {
      -- Remove the condition to allow Biome to run without config file
      -- Biome has sane defaults and works without biome.json
      prepend_args = { "--stdin-file-path", "$FILENAME" },
    },
    eslint_d = {
      condition = function(ctx)
        return vim.fs.find({
          ".eslintrc.js",
          ".eslintrc.json",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          "eslint.config.js",
          "eslint.config.mjs",
        }, { path = ctx.filename, upward = true })[1]
      end,
    },
    gofumpt = {
      prepend_args = { "-extra" }, -- More aggressive formatting
    },
    goimports = {
      prepend_args = { "-local", vim.fn.getcwd() },
    },
  },
}

return options
