return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  priority = 100,
  config = function()
    require("transparent").setup({
      extra_groups = {
        -- Core
        "Normal", "NormalNC", "NormalFloat",
        "Pmenu", "PmenuSbar", "PmenuThumb",  -- Pmenu trong suốt, KHÔNG thêm PmenuSel
        "StatusLine", "StatusLineNC",

        -- LSP
        "LspInfoBorder", "LspInfoNormal",
        "DiagnosticVirtualTextError", "DiagnosticVirtualTextWarn",
        "DiagnosticVirtualTextInfo", "DiagnosticVirtualTextHint",

        -- FzfLua
        "FzfLuaBorder", "FzfLuaNormal", "FzfLuaTitle",
        "FzfLuaPreviewBorder", "FzfLuaPreviewNormal", "FzfLuaPreviewTitle",

        -- NeoTree
        "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeFloatBorder",
        "NeoTreeEndOfBuffer", "NeoTreeWinSeparator",

        -- Plugins UI
        "TelescopeBorder",
        "LazyNormal", "MasonNormal",
        "CmpDocumentation", "CmpDocumentationBorder",
      },
    })

    -- Clear lualine backgrounds
    require("transparent").clear_prefix("lualine")
  end,
}
