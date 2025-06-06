-- Make eruby snippets available in yaml files
return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      providers = {
        snippets = {
          opts = {
            extended_filetypes = {
              yaml = { "eruby" },
            },
          },
        },
      },
    },
  },
}
