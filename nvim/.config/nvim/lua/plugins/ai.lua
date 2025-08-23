return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter", -- Only load when entering insert mode
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
}