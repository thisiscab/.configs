return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "pyright",
          "bashls",
          "cssls",
          "dockerls",
          "jsonls",
          "vimls",
          "html",
          "terraformls",
          "sqlls",
          "gopls",
          "tailwindcss",
          "eslint",
          "lua_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("thisiscab.lsp")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- Configuration is handled in thisiscab.lsp
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
  },
  {
    "rafamadriz/friendly-snippets",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          vue = { { "prettierd", "prettier" } },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
          less = { { "prettierd", "prettier" } },
          html = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          jsonc = { { "prettierd", "prettier" } },
          yaml = { { "prettierd", "prettier" } },
          markdown = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },
          handlebars = { "prettier" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          go = { "gofmt" },
          terraform = { "terraform_fmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      
      -- Create a custom eslint_d linter that handles missing config gracefully
      lint.linters.eslint_d_safe = vim.tbl_deep_extend("force", lint.linters.eslint_d, {
        cmd = function()
          -- Check if we're in a directory with ESLint config
          local config_files = {
            ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml", 
            ".eslintrc", "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs"
          }
          
          for _, config_file in ipairs(config_files) do
            if vim.fn.findfile(config_file, ".;") ~= "" then
              return "eslint_d"
            end
          end
          
          -- Also check if package.json has eslintConfig
          local package_json = vim.fn.findfile("package.json", ".;")
          if package_json ~= "" then
            local ok, content = pcall(vim.fn.readfile, package_json)
            if ok and type(content) == "table" then
              local json_str = table.concat(content, "\n")
              if json_str:match('"eslintConfig"') then
                return "eslint_d"
              end
            end
          end
          
          -- Return a dummy command that does nothing if no config found
          return "true"
        end,
      })
      
      lint.linters_by_ft = {
        javascript = { "eslint_d_safe" },
        typescript = { "eslint_d_safe" },
        javascriptreact = { "eslint_d_safe" },
        typescriptreact = { "eslint_d_safe" },
        python = { "flake8" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      }
      
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}