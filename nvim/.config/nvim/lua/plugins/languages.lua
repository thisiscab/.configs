return {
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
    config = function()
      require("thisiscab.terraform")
    end,
  },
  {
    "fatih/vim-go",
    ft = { "go" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
    ft = { "markdown", "vim-plug" },
    config = function()
      require("thisiscab.markdown-preview")
    end,
  },
}