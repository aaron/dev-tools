-- Disable run migrations popup dialog
-- https://github.com/Shopify/ruby-lsp/blob/main/jekyll/editors.markdown
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          init_options = {
            addonSettings = {
              ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
              },
            },
          },
        },
      },
    },
  },
}
