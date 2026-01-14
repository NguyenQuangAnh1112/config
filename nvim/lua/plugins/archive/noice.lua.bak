return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          background_colour = "#282828", -- Màu nền theo gruvbox
        })
      end,
    },
  },
  config = function()
    require("noice").setup({
      cmdline = {
        view = "cmdline", -- Hoặc "popup"
      },
      presets = {
        bottom_search = true,
        command_palette = true,
      },
    })
  end,
}

