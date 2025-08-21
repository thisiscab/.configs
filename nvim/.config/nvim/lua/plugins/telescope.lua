return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    cmd = { "Telescope" },
    keys = {
      { "<leader>sr", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>sl", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>sf", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
    },
    config = function()
      require("thisiscab.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
  },
}