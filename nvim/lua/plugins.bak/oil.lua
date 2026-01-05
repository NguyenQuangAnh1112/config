return {
  "stevearc/oil.nvim",
  dependencies = {
    -- Sử dụng biểu tượng đẹp hơn
    {
      "echasnovski/mini.icons",
      opts = {
        style = "glyphs",
      },
    },
    -- Hoặc nếu bạn dùng nvim-web-devicons
    -- "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
  },
  keys = {
    -- Mở oil bằng <Leader>o
    { "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil File Explorer" },
  },
  -- Bạn có thể disable lazy loading nếu gặp vấn đề
  -- lazy = false,
}

