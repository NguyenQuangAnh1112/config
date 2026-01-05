return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = {
          normal = {
            a = { fg = "#ffffff", bg = "#3c3836", gui = "bold" }, -- nền tối nhẹ
            b = { fg = "#ffffff", bg = "NONE" },
            c = { fg = "#ffffff", bg = "NONE" },
          },
          insert = {
            a = { fg = "#ffffff", bg = "#3c3836", gui = "bold" },
            b = { fg = "#ffffff", bg = "NONE" },
            c = { fg = "#ffffff", bg = "NONE" },
          },
          visual = {
            a = { fg = "#ffffff", bg = "#3c3836", gui = "bold" },
            b = { fg = "#ffffff", bg = "NONE" },
            c = { fg = "#ffffff", bg = "NONE" },
          },
          replace = {
            a = { fg = "#ffffff", bg = "#3c3836", gui = "bold" },
            b = { fg = "#ffffff", bg = "NONE" },
            c = { fg = "#ffffff", bg = "NONE" },
          },
          command = {
            a = { fg = "#ffffff", bg = "#3c3836", gui = "bold" },
            b = { fg = "#ffffff", bg = "NONE" },
            c = { fg = "#ffffff", bg = "NONE" },
          },
          inactive = {
            a = { fg = "#aaaaaa", bg = "#1d2021" },
            b = { fg = "#aaaaaa", bg = "NONE" },
            c = { fg = "#aaaaaa", bg = "NONE" },
          },
        },
        globalstatus = true,
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}

