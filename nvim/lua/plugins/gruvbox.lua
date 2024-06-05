return {
  {
    "sainnhe/gruvbox-material",
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      theme = "gruvbox-material",
    },
  },
}
