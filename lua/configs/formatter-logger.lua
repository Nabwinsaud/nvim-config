local M = {}

-- Function to show which formatter is being used
M.show_active_formatters = function()
  local conform = require "conform"
  local bufnr = vim.api.nvim_get_current_buf()

  -- Get formatters for current buffer
  local formatters = conform.list_formatters_for_buffer(bufnr)

  if formatters and #formatters > 0 then
    local formatter_names = {}
    for _, formatter in ipairs(formatters) do
      table.insert(formatter_names, formatter.name)
    end

    vim.notify("Active formatters: " .. table.concat(formatter_names, ", "), vim.log.levels.INFO)
  else
    vim.notify("No formatters available for current buffer", vim.log.levels.WARN)
  end
end

-- Auto-notify which formatter is being used on save
M.setup_formatter_notifications = function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      local conform = require "conform"
      local bufnr = vim.api.nvim_get_current_buf()
      local formatters = conform.list_formatters_for_buffer(bufnr)

      if formatters and #formatters > 0 then
        local formatter_names = {}
        for _, formatter in ipairs(formatters) do
          table.insert(formatter_names, formatter.name)
        end

        vim.notify("Formatting with: " .. table.concat(formatter_names, " → "), vim.log.levels.INFO)
      end
    end,
  })
end

return M
