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
          python = { "isort", "black" }, -- isort trước, black sau
          cpp = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = false, -- tránh format trùng style
        },
      })
    end,
  },

  -- =========================
  -- 🚨 LINTER
  -- =========================
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost" },
    config = function()
      require("lint").linters_by_ft = {
        python = { "flake8" }, -- hoặc đổi sang "ruff"
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
