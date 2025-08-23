return {
  -- Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        background_colour = "#000000",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 5000,
      })
    end,
  },
  
  -- Modern code outline
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Toggle Symbols Outline" },
    },
    config = function()
      require("aerial").setup({
        backends = { "lsp", "treesitter", "markdown", "man" },
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 10,
          default_direction = "prefer_right",
        },
        show_guides = true,
        guides = {
          mid_item = "├─",
          last_item = "└─",
          nested_top = "│ ",
          whitespace = "  ",
        },
      })
    end,
  },
  
  -- Git integration improvements
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
        },
        preview_config = {
          border = "rounded",
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      })
    end,
  },
  
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
      })
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
  },
}