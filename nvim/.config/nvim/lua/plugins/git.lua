return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse", "GBlame" },
    dependencies = {
      "tpope/vim-rhubarb",
      "shumphrey/fugitive-gitlab.vim",
    },
  },
  {
    "tpope/vim-rhubarb",
  },
  {
    "shumphrey/fugitive-gitlab.vim",
  },
}