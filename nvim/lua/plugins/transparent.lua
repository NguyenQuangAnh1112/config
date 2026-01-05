return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        -- Giữ nguyên
        "Normal",
        "NormalNC",
        "TelescopeBorder",
        -- "NvimTreeNormal",
        "LualineNormal",
        "FzfLuaBorder",
        "FzfLuaNormal",
        "FzfLuaTitle",
        "FzfLuaPreviewBorder",
        "FzfLuaPreviewNormal",
        "FzfLuaPreviewTitle",

        -- Gợi ý từ nvim-cmp
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",

        -- Cửa sổ nổi LSP
        "NormalFloat",
        "FloatBorder",
        "LspInfoBorder",
        "LspInfoNormal",
        "DiagnosticVirtualTextError",
        "DiagnosticVirtualTextWarn",
        "DiagnosticVirtualTextInfo",
        "DiagnosticVirtualTextHint",

        -- NeoTree
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeFloatBorder",
        "NeoTreeEndOfBuffer",
        "NeoTreeWinSeparator",

        -- Lazy, Mason, Noice
        "LazyNormal",
        "MasonNormal",
        "NoicePopup",
        "NoiceCmdlinePopup",
        "NoicePopupmenu",
        "CmpDocumentation",
        "CmpDocumentationBorder",

        -- Lualine
        "StatusLine",
        "StatusLineNC",
      },
    })

    -- Làm sạch prefix
    require("transparent").clear_prefix("lualine")

    -- Các lệnh highlight thủ công
    vim.cmd("highlight Normal guibg=NONE")
    vim.cmd("highlight NormalNC guibg=NONE")
    vim.cmd("highlight CursorLine guibg=NONE")
    vim.cmd("highlight Lualine guibg=NONE")
    vim.cmd("highlight Lualine guifg=NONE")
    vim.cmd("highlight FloatBorder guibg=NONE")
    vim.cmd("highlight NormalFloat guibg=NONE")
    vim.cmd("highlight Pmenu guibg=NONE")
  end,
}

