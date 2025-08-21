return {
  {
    "editorconfig/editorconfig-vim",
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VimEnter",
    config = function()
      require("thisiscab.tmux")
    end,
  },
  {
    "terrortylor/nvim-comment",
    event = "BufReadPre",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("thisiscab.comment")
    end,
  },
  {
    "sbdchd/neoformat",
    cmd = { "Neoformat" },
    config = function()
      require("thisiscab.neoformat")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
    },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache" },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = true,
            },
          },
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
        current_line_blame = false,
      })
    end,
  },
}