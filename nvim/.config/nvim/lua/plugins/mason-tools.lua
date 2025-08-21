return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP servers (managed by mason-lspconfig)
          -- Formatters
          "prettier",
          "black",
          "isort",
          "stylua",
          "shfmt",
          -- Linters
          "eslint_d",
          "flake8",
          "shellcheck",
          -- DAP
          "debugpy",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}