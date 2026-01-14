return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "python", "lua", "vim", "bash", "markdown", "cpp", "c"
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    -- Tạm tắt incremental_selection vì gây lỗi với một số file
    -- Bật lại nếu cần: uncomment block bên dưới
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "<C-space>",
    --     node_incremental = "<C-space>",
    --     scope_incremental = false,
    --     node_decremental = "<bs>",
    --   },
    -- },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

