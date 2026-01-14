return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  -- 📝 Hiển thị tham số hàm khi gõ code
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded", -- Viền popup
      },
      hint_enable = true, -- Hiện virtual text hint
      hint_prefix = "🔹 ", -- Icon prefix cho hint
      floating_window = true, -- Hiện popup
      floating_window_above_cur_line = true, -- Popup ở trên dòng hiện tại
      hi_parameter = "LspSignatureActiveParameter", -- Highlight tham số hiện tại
      always_trigger = false, -- Chỉ trigger khi cần
      toggle_key = "<C-k>", -- Phím tắt để toggle signature help
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff", "clangd" },
        automatic_installation = true,
        handlers = {
          -- Handler mặc định
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          -- Handler riêng cho pyright (type checking only)
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                  },
                },
              },
            })
          end,
          -- Handler riêng cho ruff (linting + code actions)
          ["ruff"] = function()
            require("lspconfig").ruff.setup({
              on_attach = function(client, bufnr)
                -- Tắt hover của ruff (dùng pyright thay thế)
                client.server_capabilities.hoverProvider = false
                
                -- Auto organize imports khi save
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.code_action({
                      context = { only = { "source.organizeImports" } },
                      apply = true,
                    })
                    vim.wait(100) -- Đợi action hoàn thành
                  end,
                })
              end,
              init_options = {
                settings = {
                  organizeImports = true,
                  fixAll = true,
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
    },
    -- Không gọi setup() ở đây - để mason-lspconfig xử lý
  },
}
