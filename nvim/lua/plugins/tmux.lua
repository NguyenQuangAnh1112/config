-- ~/.config/nvim/lua/plugins/tmux.lua
return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy", -- Lazy load thay vì load ngay
  config = function()
    -- Cấu hình mặc định thường là đủ, nhưng bạn có thể thêm keymaps tùy chỉnh ở đây nếu muốn
    -- Ví dụ: nếu bạn muốn dùng tổ hợp phím khác
    vim.g.tmux_navigator_no_default_key_mappings = 1 -- Tắt keymap mặc định
    vim.keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { silent = true })
    vim.keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { silent = true })
    vim.keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { silent = true })
    vim.keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { silent = true })
    vim.keymap.set('n', '<C-\\>', '<Cmd>TmuxNavigatePrevious<CR>', { silent = true })
  end,
}
