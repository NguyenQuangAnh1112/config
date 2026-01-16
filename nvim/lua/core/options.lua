local opt = vim.opt
local g = vim.g

-- Tắt các provider không dùng (tránh warning trong checkhealth)
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python_provider = 0 -- Chỉ dùng python3 provider

-- ==== UI ====
opt.number = true             -- Hiển thị số dòng
opt.relativenumber = false    -- Không dùng số dòng tương đối
opt.cursorline = true         -- Highlight dòng con trỏ
opt.termguicolors = true      -- Hỗ trợ màu GUI
opt.signcolumn = "yes"        -- Luôn hiện cột dấu hiệu (LSP, Git,...)
opt.wrap = true               -- Tự xuống dòng khi quá dài
opt.linebreak = true          -- không ngắt từ khi xuống dòng
opt.scrolloff = 5             -- Giữ khoảng cách khi cuộn
vim.o.showmode = false        -- Tắt mode (INSERT / NORMAL)
opt.inccommand = "split"      -- Live preview khi thay thế

-- ==== Tìm kiếm ====
opt.ignorecase = true         -- Không phân biệt hoa/thường
opt.smartcase = true          -- Nếu có 1 chữ hoa → phân biệt

-- ==== Indentation ====
opt.tabstop = 4               -- tab = 4
opt.shiftwidth = 4            -- >> và <<
opt.expandtab = true          -- tab → space
opt.smartindent = true        -- indent thông minh

-- ==== Tương tác ====
opt.clipboard = "unnamedplus" -- Copy/paste hệ thống
opt.mouse = "a"               -- Cho phép dùng chuột

-- ==== Undo / Backup ====
opt.undofile = true           -- Lưu file undo
opt.swapfile = false          -- Không dùng swap
opt.backup = false            -- Không backup

-- ==== Timing ====
opt.updatetime = 300          -- Thời gian chờ LSP/diagnostic
opt.timeoutlen = 400          -- Timeout cho mapped sequence

-- =========================
-- 🔴 DIAGNOSTIC CONFIG (LazyVim style)
-- =========================
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",             -- Icon trước message
    spacing = 4,              -- Khoảng cách từ code
    format = function(diagnostic)
      -- Chỉ hiện message ngắn gọn
      local message = diagnostic.message:match("^[^\n]+") or diagnostic.message
      if #message > 60 then
        message = message:sub(1, 57) .. "..."
      end
      return message
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,       -- Lỗi nghiêm trọng hiện trước
  float = {
    border = "rounded",
    source = true,
  },
})

-- =========================
-- 🎨 COMPLETION MENU HIGHLIGHT
-- =========================
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#45475a", bold = true })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#ffffff", bg = "NONE" })  -- Viền trắng

-- =========================
-- 🔵 INLAY HINTS HIGHLIGHT
-- =========================
vim.api.nvim_set_hl(0, "LspInlayHint", {
  fg = "#7a7a7a",  -- Màu xám nhạt
  bg = "NONE",
  italic = true,
})
