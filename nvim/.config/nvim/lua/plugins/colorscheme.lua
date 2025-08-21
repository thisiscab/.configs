return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false, -- Load immediately
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
}