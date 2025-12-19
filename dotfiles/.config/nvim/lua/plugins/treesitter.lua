-- Add ruby indentation settings from kickstart.nvim init.lua
-- Disable Treesitter indentation
-- Enable vim's regex highlighting system
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    indent = {
      enable = true,
      disable = { "ruby" },
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
    -- Re-sign parsers after build (macOS code signing fix)
    vim.defer_fn(function()
      local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
      vim.fn.system("for so in " .. parser_dir .. "/*.so; do codesign -s - -f \"$so\" 2>/dev/null; done")
    end, 1000)
  end,
}
