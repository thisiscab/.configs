return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
      { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus Explorer" },
    },
    config = function()
      require("neo-tree").setup({
        default_component_configs = {
          icon = {
            folder_closed = "+",
            folder_open = "-",
            folder_empty = "+",
            default = " ",
          },
          git_status = {
            symbols = {
              added = "+",
              modified = "~",
              deleted = "-",
              renamed = "R",
              untracked = "?",
              ignored = "!",
              unstaged = "U",
              staged = "S",
              conflict = "C",
            },
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
        },
        window = {
          width = 30,
          mappings = {
            ["<space>"] = "none",
          },
        },
      })
    end,
  },
  
  -- Improved startup time
  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
    end,
  },
}