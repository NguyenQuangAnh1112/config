return {
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000, -- load sớm
    config = function()
      require("monokai-pro").setup({
        filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
        transparent_background = false,
        terminal_colors = true,
        devicons = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true },
          type = { italic = false },
        },
      })

      vim.cmd("colorscheme monokai-pro")
    end,
  },
}
