return {
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "OverseerToggle",
      "OverseerRun", 
      "OverseerTaskAction",
      "OverseerClearCache",
      "OverseerQuickAction"
    },
    keys = {
      { "<leader>bb", "<cmd>OverseerToggle<cr>", desc = "Toggle Task Runner" },
      { "<leader>br", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>ba", "<cmd>OverseerTaskAction<cr>", desc = "Task Actions" },
      { "<leader>bc", "<cmd>OverseerClearCache<cr>", desc = "Clear Task Cache" },
      { "<leader>bq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
    },
    config = function()
      require("overseer").setup({
        templates = { "builtin" },
        task_list = {
          default_detail = 1,
          direction = "bottom",
          -- Auto-open task list when task starts
        },
        -- Component aliases to send output to quickfix
        component_aliases = {
          default = {
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
            { "on_output_parse", problem_matcher = "$eslint-stylish" },
          },
        },
        -- Auto-open task list on task start
        task_win = {
          padding = 1,
          border = "rounded",
        },
        confirm = {
          border = "rounded",
        },
        task_editor = {
          border = "rounded",
        },
      })
      
      -- Set window navigation keymaps for overseer buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "OverseerList",
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
          vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
          vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
          vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
        end,
      })
      
      -- Ensure we override vim.ui.select with telescope AFTER overseer loads
      vim.schedule(function()
        -- Force telescope ui-select to be used
        local telescope = require("telescope")
        telescope.load_extension("ui-select")
      end)
    end,
  },
}