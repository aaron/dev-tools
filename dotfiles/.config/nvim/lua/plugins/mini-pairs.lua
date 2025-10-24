-- Allow auopairing inside treesitter string nodes
return {
  "nvim-mini/mini.pairs",
  event = "VeryLazy",
  config = function()
    local opts = require("mini.pairs").config
    opts.skip_ts = false
    require("mini.pairs").setup(opts)
  end,
}
