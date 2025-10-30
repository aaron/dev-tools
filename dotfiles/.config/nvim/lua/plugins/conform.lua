return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      htmlbeautifier = {
        command = "bundle",
        args = { "exec", "htmlbeautifier", "--keep-blank-lines", "1" },
      },
    },
    formatters_by_ft = {
      eruby = { "htmlbeautifier" },
      ruby = { "rubocop" },
    },
  },
}
