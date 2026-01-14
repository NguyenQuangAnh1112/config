return {
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        enable = true,
        extra_groups = {
          "Normal",
          "NormalNC",
          "TelescopeBorder",
          "LualineNormal",
          "FzfLuaBorder",
          "FzfLuaNormal",
          "FzfLuaTitle",
          "FzfLuaPreviewBorder",
          "FzfLuaPreviewNormal",
          "FzfLuaPreviewTitle",
          "Pmenu",
          "PmenuSel",
          "PmenuSbar",
          "PmenuThumb",
          "NormalFloat",
          "FloatBorder",
          "LspInfoBorder",
          "LspInfoNormal",
          "DiagnosticVirtualTextError",
          "DiagnosticVirtualTextWarn",
          "DiagnosticVirtualTextInfo",
          "DiagnosticVirtualTextHint",
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "NeoTreeFloatBorder",
          "NeoTreeEndOfBuffer",
          "NeoTreeWinSeparator",
          "LazyNormal",
          "MasonNormal",
          "NoicePopup",
          "NoiceCmdlinePopup",
          "NoicePopupmenu",
          "CmpDocumentation",
          "CmpDocumentationBorder",
          "StatusLine",
          "StatusLineNC",
        },
      })

      require("transparent").clear_prefix("lualine")

      vim.cmd("highlight Normal guibg=NONE")
      vim.cmd("highlight NormalNC guibg=NONE")
      vim.cmd("highlight Lualine guibg=NONE")
      vim.cmd("highlight Lualine guifg=NONE")
      vim.cmd("highlight FloatBorder guibg=NONE")
      vim.cmd("highlight NormalFloat guibg=NONE")
      vim.cmd("highlight Pmenu guibg=NONE")
    end,
  },
}
