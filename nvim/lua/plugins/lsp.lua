return {
  -- Mason core
  { "williamboman/mason.nvim", config = true },

  -- Hiển thị tham số hàm khi gõ (popup)
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = { border = "rounded" },
      hint_enable = true,
      hint_prefix = "🔹 ",
      floating_window = true,
      floating_window_above_cur_line = true,
      hi_parameter = "LspSignatureActiveParameter",
      always_trigger = false,
      toggle_key = "<C-k>",
    },
  },

  -- LSP progress indicator
  { "j-hui/fidget.nvim", opts = {} },

  -- Mason + LSP config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Tự động bật Inlay Hints khi LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })

      -- Chỉ hiện Inlay Hints ở Normal Mode (ẩn khi gõ)
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
        end,
      })
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "basedpyright", "ruff", "clangd" },
        automatic_installation = true,
        handlers = {
          -- Default handler cho các LSP khác
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Python: Type Checker
          basedpyright = function()
            lspconfig.basedpyright.setup({
              capabilities = capabilities,
              on_attach = function(client, _)
                -- Tắt signature để dùng lsp_signature.nvim
                client.server_capabilities.signatureHelpProvider = false
              end,
              settings = {
                basedpyright = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                    typeCheckingMode = "standard",
                    autoImportCompletions = true,
                    inlayHints = {
                      callArgumentNames = "all",
                      functionReturnTypes = true,
                      variableTypes = true,
                      genericTypes = true,
                    },
                  },
                },
              },
            })
          end,

          -- Python: Linter + Formatter
          ruff = function()
            lspconfig.ruff.setup({
              capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-16" } }),
              on_attach = function(client, bufnr)
                client.server_capabilities.hoverProvider = false
                -- Auto organize imports on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.code_action({
                      context = { only = { "source.organizeImports" } },
                      apply = true,
                    })
                  end,
                })
              end,
              init_options = {
                settings = { fixAll = true, organizeImports = true },
              },
            })
          end,
        },
      })
    end,
  },

  -- Core LSP
  { "neovim/nvim-lspconfig" },
}
