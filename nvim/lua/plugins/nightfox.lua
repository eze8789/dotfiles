return {
  { "EdenEast/nightfox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfox",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      theme = "nightfox",
    },
  },

  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    },
  },
}
