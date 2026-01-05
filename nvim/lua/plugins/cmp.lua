return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- =========================
      -- ⚙️ NEOVIM CORE OPTION
      -- =========================
      vim.o.completeopt = "menu,menuone,noselect"

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- KHÔNG tự chọn item đầu
        preselect = cmp.PreselectMode.None,

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- =========================
        -- ⌨️ KEYMAP
        -- =========================
        mapping = cmp.mapping.preset.insert({
          -- Enter chỉ xác nhận khi bạn ĐÃ chọn
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- =========================
        -- 🔌 SOURCES
        -- =========================
        sources = {
          { name = "nvim_lsp", priority = 1000, dup = 0 },
          { name = "luasnip",  priority = 750,  dup = 0 },
          { name = "buffer",   priority = 500, keyword_length = 4, dup = 0 },
          { name = "path",     priority = 250, dup = 0 },
        },

        -- =========================
        -- 🧠 SORTING
        -- =========================
        sorting = {
          comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },
}
