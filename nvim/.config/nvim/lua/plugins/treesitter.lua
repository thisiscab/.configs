return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- Keep this loaded for filetype detection and syntax highlighting
    -- build = ":TSUpdate", -- Disabled to prevent installation errors
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("thisiscab.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter" },
  },
}