return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "zidhuss/neotest-minitest",
  },
  opts = {
    adapters = {
      ["neotest-minitest"] = {
        test_cmd = function()
          return {
            "bundle",
            "exec",
            "rails",
            "test",
          }
        end,
      },
    },
  },
}
