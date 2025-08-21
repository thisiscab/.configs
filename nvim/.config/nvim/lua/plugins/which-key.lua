return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        win = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
          winblend = 0
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        spec = {
          -- Find/Files
          { "<leader>f", group = "Find/Files" },
          { "<leader>ff", "<cmd>Neoformat<cr>", desc = "Format" },
          { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
          
          -- Search
          { "<leader>s", group = "Search" },
          { "<leader>sr", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
          { "<leader>sl", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
          { "<leader>sf", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
          { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
          { "<leader>ss", "vip:sort u<cr>", desc = "Sort Paragraph" },
          { "<leader>sS", "vip:sort! u<cr>", desc = "Sort Paragraph (Reverse)" },
          
          -- Git
          { "<leader>g", group = "Git" },
          { "<leader>gs", "<cmd>Git<cr>", desc = "Status" },
          { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Diff" },
          { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
          { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
          { "<leader>gl", "<cmd>Gclog<cr>", desc = "Log" },
          { "<leader>gw", "<cmd>Gbrowse<cr>", desc = "Browse" },
          { "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
          
          -- LSP/Terminal
          { "<leader>t", group = "LSP/Terminal" },
          { "<leader>td", vim.lsp.buf.definition, desc = "Go to Definition" },
          { "<leader>tl", vim.lsp.buf.type_definition, desc = "Type Definition" },
          { "<leader>ti", vim.lsp.buf.implementation, desc = "Implementation" },
          { "<leader>th", vim.lsp.buf.hover, desc = "Hover" },
          { "<leader>te", vim.diagnostic.open_float, desc = "Show Diagnostic" },
          { "<leader>ta", vim.lsp.buf.code_action, desc = "Code Action" },
          { "<leader>tr", vim.lsp.buf.references, desc = "References" },
          { "<leader>ts", vim.lsp.buf.signature_help, desc = "Signature Help" },
          
          -- Buffer
          { "<leader>b", group = "Buffer" },
          { "<leader>bq", "<cmd>bp <BAR> bd #<cr>", desc = "Close Buffer" },
          
          -- Replace/Reload
          { "<leader>r", group = "Replace/Reload" },
          { "<leader>rt", group = "Remove Trailing" },
          { "<leader>rtw", ":%s/\\s\\+$//e<cr>", desc = "Remove Trailing Whitespace" },
          { "<leader>rr", "<cmd>source $MYVIMRC<cr>", desc = "Reload Config" },
          
          -- Misc
          { "<leader>m", group = "Misc" },
          { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
          
          -- Navigation
          { "<leader>k", "<cmd>bnext<cr>", desc = "Next Buffer" },
          { "<leader>j", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
          { "<leader>l", "<cmd>b#<cr>", desc = "Last Buffer" },
          
          -- Utility
          { "<leader>d", vim.diagnostic.open_float, desc = "Show Diagnostics" },
          { "<leader>q", vim.diagnostic.setloclist, desc = "Diagnostic List" },
          { "<leader>cs", "<cmd>noh<cr>", desc = "Clear Search" },
          { "<leader>pwd", '<cmd>echo expand("%:p")<cr>', desc = "Show Path" },
          { "<leader>snr", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", desc = "Search & Replace" },
          
          -- Visual mode sort
          { "<leader>s", group = "Sort", mode = "v" },
          { "<leader>ss", ":sort u<cr>", desc = "Sort", mode = "v" },
          { "<leader>sS", ":sort! u<cr>", desc = "Sort (Reverse)", mode = "v" },
          
          -- Diagnostic navigation
          { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
          { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
        },
      })
    end,
  },
}