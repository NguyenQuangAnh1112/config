local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- === GRUVBOX DARK THEME (Match với tmux & nvim) ===
config.colors = {
  foreground = "#ebdbb2",
  background = "#282828",
  cursor_bg = "#ebdbb2",
  cursor_fg = "#282828",
  selection_bg = "#504945",
  selection_fg = "#ebdbb2",

  ansi = {
    "#282828", -- black
    "#cc241d", -- red
    "#98971a", -- green
    "#d79921", -- yellow
    "#458588", -- blue
    "#b16286", -- magenta
    "#689d6a", -- cyan
    "#a89984", -- white
  },
  brights = {
    "#928374", -- bright black
    "#fb4934", -- bright red
    "#b8bb26", -- bright green
    "#fabd2f", -- bright yellow
    "#83a598", -- bright blue
    "#d3869b", -- bright magenta
    "#8ec07c", -- bright cyan
    "#ebdbb2", -- bright white
  },
}

-- font
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 16

-- window
config.window_background_opacity = 1
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_decorations = "NONE"
config.enable_tab_bar = false

-- Mở fullscreen mặc định
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)


return config
