return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local fzf = require("fzf-lua")

    -- Header ASCII art
    dashboard.section.header.val = {
      "       ██████╗  █████╗ ███╗   ██╗██╗  ██╗",
      "      ██╔═══██╗██╔══██╗████╗  ██║██║  ██║",
      "      ██║   ██║███████║██╔██╗ ██║███████║",
      "      ██║▄▄ ██║██╔══██║██║╚██╗██║██╔══██║",
      "      ╚██████╔╝██║  ██║██║ ╚████║██║  ██║",
      "       ╚══▀▀═╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝",
      "",
    }

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "🔍 Find file", ":lua require('fzf-lua').files()<CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent files", ":lua require('fzf-lua').oldfiles()<CR>"),
      dashboard.button("g", "  Find text", ":lua require('fzf-lua').live_grep()<CR>"),
      dashboard.button("b", "󰓩  Buffers", ":lua require('fzf-lua').buffers()<CR>"),
      dashboard.button("h", "󰞋  Help Tags", ":lua require('fzf-lua').help_tags()<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
  }

    -- Footer
    dashboard.section.footer.val = "✨ Welcome to Neovim ✨"

    -- Padding + layout setup
    alpha.setup({
      layout = {
        { type = "padding", val = 10 },  -- 👈 chỉnh số dòng đẩy header xuống
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      },
      opts = {
        margin = 5,
      },
    })
  end,
}

