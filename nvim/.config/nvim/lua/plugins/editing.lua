return {
  -- Better surround operations
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
        },
      })
      
      -- Integration with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  
  -- Better increment/decrement
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, desc = "Increment" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, desc = "Increment (g)" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, desc = "Decrement (g)" },
      { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "v", desc = "Increment" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "v", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, mode = "v", desc = "Increment (g)" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "v", desc = "Decrement (g)" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
        },
      })
    end,
  },
  
  -- Multiple cursors (removed)
}