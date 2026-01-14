-- File: lua/core/tmux-tab.lua
-- Tự động mở file mới trong tmux window mới khi đang trong tmux

local M = {}

-- Kiểm tra xem đang trong tmux không
function M.is_in_tmux()
  return vim.env.TMUX ~= nil
end

-- Mở file trong tmux window mới
function M.open_in_new_tmux_window(filepath)
  if not M.is_in_tmux() then
    -- Nếu không trong tmux, mở bình thường
    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    return
  end

  -- Lấy đường dẫn tuyệt đối của file
  local abs_path = vim.fn.fnamemodify(filepath, ":p")
  local dir = vim.fn.fnamemodify(abs_path, ":h")
  local filename = vim.fn.fnamemodify(abs_path, ":t")

  -- Tạo tmux window mới và mở nvim với file đó
  local cmd = string.format(
    "tmux new-window -c %s -n %s 'nvim %s'",
    vim.fn.shellescape(dir),
    vim.fn.shellescape(filename),
    vim.fn.shellescape(abs_path)
  )

  vim.fn.system(cmd)
end

-- Wrapper function để sử dụng với các plugin
function M.setup_fzf_integration()
  local ok, fzf = pcall(require, "fzf-lua")
  if not ok then return end

  -- Override actions cho fzf-lua
  local actions = require("fzf-lua.actions")

  -- Custom action để mở trong tmux tab mới
  M.fzf_open_in_tmux_tab = function(selected, opts)
    if not selected or #selected == 0 then return end

    local path_ok, path = pcall(require, "fzf-lua.path")

    for _, sel in ipairs(selected) do
      local filepath = sel
      -- Sử dụng fzf-lua's path utility để extract đường dẫn file đúng cách
      if path_ok then
        local entry = path.entry_to_file(sel, opts)
        filepath = entry.path or sel
      end
      -- Fallback: nếu không có path, thử parse thủ công
      if not filepath or filepath == "" or filepath == sel then
        -- Strip icon ở đầu (icon thường là 1-4 ký tự unicode + space)
        local stripped = sel:gsub("^[^%w/%.~]+", "")
        filepath = stripped:match("^([^:]+)") or stripped
      end
      M.open_in_new_tmux_window(filepath)
    end
  end
end

-- Wrapper cho neotree
function M.setup_neotree_integration()
  -- Hook vào BufReadPost để detect file mới được mở
  -- Cách này không can thiệp vào neotree core
end

-- Hook vào vim events để mở file trong tmux tab mới
-- Bạn có thể toggle feature này on/off
M.enabled = true

function M.toggle()
  M.enabled = not M.enabled
  vim.notify("Tmux Tab Mode: " .. (M.enabled and "ON" or "OFF"), vim.log.levels.INFO)
end

-- Thiết lập autocmd để hook vào việc mở file
function M.setup(opts)
  opts = opts or {}

  -- Mặc định là bật
  M.enabled = opts.enabled ~= false

  -- Danh sách các file type/buffer type cần bỏ qua
  M.ignore_buftypes = opts.ignore_buftypes or { "nofile", "terminal", "quickfix", "prompt" }
  M.ignore_filetypes = opts.ignore_filetypes or { "neo-tree", "fzf", "TelescopePrompt", "lazy", "mason" }

  -- Không tự động hook vào BufReadPost vì sẽ gây conflict
  -- Thay vào đó, ta sẽ cung cấp custom function để dùng với keymaps

  -- Setup integrations
  M.setup_fzf_integration()

  -- Tạo command để toggle
  vim.api.nvim_create_user_command("TmuxTabToggle", function()
    M.toggle()
  end, { desc = "Toggle Tmux Tab Mode" })

  -- Tạo command để mở file trong tmux tab mới
  vim.api.nvim_create_user_command("TmuxTabOpen", function(cmd_opts)
    M.open_in_new_tmux_window(cmd_opts.args)
  end, { nargs = 1, complete = "file", desc = "Open file in new tmux tab" })
end

return M
