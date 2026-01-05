return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "clangd" },
        automatic_installation = true,
        handlers = {
          -- Handler mặc định
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          -- Handler riêng cho pyright
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