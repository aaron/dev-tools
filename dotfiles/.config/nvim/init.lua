-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Reload current browser tab
vim.api.nvim_create_user_command("ReloadChrome", function()
  -- Save current buffer
  vim.cmd("write")

  -- Reload browser page
  vim.fn.jobstart({
    "osascript",
    "-e",
    'tell application "Google Chrome" to tell the active tab of its first window to reload',
    -- 'tell application "Safari" to set URL of document 1 to URL of document 1',
  }, { detach = true })
end, {})

-- Remove erb tags
vim.api.nvim_create_user_command("RemoveErbTags", function()
  vim.cmd([[%s/<%=\?\s*\|\s*%>//g]])
end, {})

-- Replace all single quotes with double quotes
vim.api.nvim_create_user_command("QuoteSwap", function()
  vim.cmd([[%s/'/"/g]])
end, {})
