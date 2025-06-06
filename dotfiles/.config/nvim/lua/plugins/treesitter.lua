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
}
