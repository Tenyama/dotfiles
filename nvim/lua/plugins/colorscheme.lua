return {
  -- Change your ass color here
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  -- Make :Telescope colorscheme prveview
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    },
  },
}
