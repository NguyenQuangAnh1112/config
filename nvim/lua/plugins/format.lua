return {
  -- =========================
  -- 🎨 FORMATTER
  -- =========================
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" }, -- organize imports + format
          cpp = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = false,
        },
      })
    end,
  },

  -- =========================
  -- 🚨 LINTER (C++ only - Python dùng ruff_lsp)
  -- =========================
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost" },
    config = function()
      require("lint").linters_by_ft = {
        cpp = { "cpplint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
