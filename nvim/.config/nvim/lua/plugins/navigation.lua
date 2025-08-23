return {

  
  -- Trouble for better diagnostics
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      { "gR", "<cmd>Trouble lsp_references<cr>", desc = "LSP References" },
    },
    config = function()
      require("trouble").setup({
        icons = {
          indent = {
            middle = " ",
            last = " ",
            top = " ",
            ws = "  ",
          },
        },
        modes = {
          diagnostics = {
            groups = {
              { "filename", format = "{file_icon} {basename:Title} {count}" }
            },
          },
        },
      })
    end,
  },

  -- Better quickfix/location list
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          auto_preview = false,
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
      })
    end,
  },
}