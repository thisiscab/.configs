return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox-material",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          icons_enabled = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = "E:", warn = "W:", info = "I:" },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              shorting_target = 40,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
              },
            },
          },
          lualine_x = {
            {
              "filetype",
              colored = true,
              icon_only = false,
            },
            "encoding",
            "fileformat",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "fugitive", "nvim-tree", "telescope" },
      })
    end,
  },
}