return {
  {
    "Saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",

    -- Sử dụng phiên bản release mới nhất
    version = "v0.*",

    opts = {
      -- 'default' cho mappings cơ bản hoặc cấu hình riêng bên dưới
      keymap = {
        preset = "none",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },

      appearance = {
        -- Sử dụng cấu hình icons mặc định
        use_nvim_cmp_as_default = true,
        -- Thay đổi độ mờ của icons
        nerd_font_variant = "mono",
      },

      -- Sources mặc định
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- Cấu hình hiển thị menu
      completion = {
        menu = {
          border = "rounded",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- Hiển thị thông tin signature khi gõ hàm
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
    },
    -- Tự động cài đặt rust/cargo nếu cần (blink.cmp cần build)
    -- build = "cargo build --release",
  },
}
