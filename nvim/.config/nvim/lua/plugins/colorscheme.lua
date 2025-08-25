return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false, -- Load immediately
    config = function()
      vim.opt.termguicolors = true
      
      -- Always default to dark, only switch to light if explicitly set
      local theme_mode = "dark"
      local theme_file = vim.fn.expand("~/.theme_mode")
      if vim.fn.filereadable(theme_file) == 1 then
        local file_content = vim.fn.readfile(theme_file)[1] or ""
        if file_content:match("light") then
          theme_mode = "light"
        end
      end
      
      vim.opt.background = theme_mode
      vim.cmd("colorscheme gruvbox-material")
      
      -- Add command to toggle theme
      vim.api.nvim_create_user_command("Light", function()
        vim.opt.background = "light"
        vim.fn.writefile({"export THEME_MODE=light"}, vim.fn.expand("~/.theme_mode"))
      end, {})
      
      vim.api.nvim_create_user_command("Dark", function()
        vim.opt.background = "dark"  
        vim.fn.writefile({"export THEME_MODE=dark"}, vim.fn.expand("~/.theme_mode"))
      end, {})
    end,
  },
}