-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Re-sign treesitter parsers after they're compiled (macOS code signing fix)
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdatePost",
  callback = function()
    local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
    vim.fn.jobstart({ "sh", "-c", "for so in " .. parser_dir .. "/*.so; do codesign -s - -f \"$so\" 2>/dev/null; done" }, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.notify("Re-signed treesitter parsers", vim.log.levels.INFO)
        end
      end,
    })
  end,
})
