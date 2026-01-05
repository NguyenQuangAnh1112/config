local opt = vim.opt
local g = vim.g

-- Giao diện
opt.number = true            -- Hiển thị số dòng
opt.relativenumber = true    -- Số dòng tương đối
opt.cursorline = true        -- Gạch chân dòng hiện tại
opt.termguicolors = true     -- Hỗ trợ màu GUI

-- Tìm kiếm
opt.ignorecase = true        -- Không phân biệt hoa/thường
opt.smartcase = true         -- Nếu có 1 chữ hoa → phân biệt

-- Indentation
opt.tabstop = 4              -- Số khoảng trắng cho tab
opt.shiftwidth = 4           -- Số khoảng trắng khi >> <<
opt.expandtab = true         -- Biến tab thành space
opt.smartindent = true

-- Giao diện hiển thị
opt.wrap = true             -- Không tự xuống dòng
opt.signcolumn = "yes"       -- Luôn hiện cột dấu hiệu (LSP, Git...)
vim.opt.linebreak = true    -- không bị ngắt giữa từ khi xuống dòng

-- Tương tác
opt.clipboard = "unnamedplus"  -- Copy/paste với hệ thống
opt.mouse = "a"                -- Cho phép dùng chuột

-- Undo
opt.undofile = true            -- Bật file undo
opt.swapfile = false           -- Tắt file swap
opt.backup = false

-- Tốc độ
opt.updatetime = 300           -- Thời gian chờ (ms)
opt.timeoutlen = 400           -- Timeout cho mapped sequence

--  tắt dòng trạng thái
vim.o.showmode = false

vim.opt.number = true          -- Bật số dòng tuyệt đối
vim.opt.relativenumber = false   -- Tắt số dòng tương đối

vim.opt.inccommand = 'split'

vim.opt.scrolloff = 20

