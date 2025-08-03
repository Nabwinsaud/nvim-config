local M = {}

-- Treesitter parsers
M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "gitignore",
    "go",
    "gomod",
    "gowork",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

M.mason = {
  ensure_installed = {
    -- LSP servers (Mason package names)
    "lua-language-server",
    "typescript-language-server",
    "html-lsp",
    "css-lsp",
    "clangd",
    "gopls",

    -- json / yaml / toml / markdown servers
    "json-lsp",
    "yaml-language-server",
    "markdownlint",
    "taplo", -- toml

    -- Formatters/linters/DAP/debuggers
    "stylua",
    "clang-format",
    "delve",
    "go-debug-adapter",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "gomodifytags",
    "gofumpt",
    "goimports",
    "goimports-reviser",
    "shellcheck",
    "shellharden",
  },
}

-- Mason LSPConfig servers (LSP config names)
M.lspconfig = {
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "html",
    "cssls",
    "clangd",
    "gopls",
    -- formatters
    "biome",
    "eslint",

    "jsonls",
    "yamlls",
    "taplo", -- toml
    "markdownlint",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}
return M
