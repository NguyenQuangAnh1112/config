return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "renerocksai/telekasten.nvim", -- Báo cho lazy.nvim biết telescope phụ thuộc vào telekasten
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      -- Cấu hình mặc định của Telescope
      defaults = {
        -- ...
      },
      pickers = {
        -- ...
      },
      extensions = {
        -- ...
      },
    })

    -- Bây giờ dòng này sẽ hoạt động vì telekasten đã được tải trước
    pcall(telescope.load_extension, "telekasten")
  end,
}
