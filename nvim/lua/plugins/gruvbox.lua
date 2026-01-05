return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Đảm bảo theme load trước
    config = function()
      -- chọn "dark" hoặc "light"
      vim.o.background = "dark"  -- hoặc "light"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}

