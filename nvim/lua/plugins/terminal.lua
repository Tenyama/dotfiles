return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
          border = "rounded",
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      local function set_terminal_colors()
        vim.g.terminal_color_0 = "#1D1C28"
        vim.g.terminal_color_1 = "#ac3231"
        vim.g.terminal_color_2 = "#2abf90"
        vim.g.terminal_color_3 = "#ebd99c"
        vim.g.terminal_color_4 = "#ac3231"
        vim.g.terminal_color_5 = "#92365e"
        vim.g.terminal_color_6 = "#009691"
        vim.g.terminal_color_7 = "#e7e7e7"
        vim.g.terminal_color_8 = "#52263e"
        vim.g.terminal_color_9 = "#ac3231"
        vim.g.terminal_color_10 = "#2abf90"
        vim.g.terminal_color_11 = "#ebd99c"
        vim.g.terminal_color_12 = "#32355a"
        vim.g.terminal_color_13 = "#92365e"
        vim.g.terminal_color_14 = "#009691"
        vim.g.terminal_color_15 = "#e7e7e7"
      end

      set_terminal_colors()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_terminal_colors,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
}
