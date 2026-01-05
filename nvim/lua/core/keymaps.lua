-- File: /home/muggle/.config/nvim/lua/core/keymaps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Dùng cho định nghĩa phím tắt ngắn gọn hơn
local map = vim.keymap.set
-- Bạn không cần biến opts ở đây vì bạn đang định nghĩa desc cho từng phím tắt
-- local opts = { noremap = true, silent = true }

-- Các keymap cơ bản
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })
map("n", "`", "<Esc>", { desc = "Escape" })
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- =========================
-- 📝 LSP Keymaps
-- =========================
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })

-- =========================
-- 🔍 Diagnostics
-- =========================
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

-- =========================
-- 🪟 Window Navigation
-- =========================
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close Split" })

-- =========================
-- 📑 Buffer Navigation
-- =========================
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bp", ":bprev<CR>", { desc = "Previous Buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

-- =========================
-- 🐛 Debug (DAP) Keymaps
-- =========================
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })


-- exit ter
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- on ter
vim.keymap.set('n', '<leader>st', function()
  vim.cmd('vsplit | terminal')
  vim.cmd('wincmd r') -- đảm bảo focus ở cửa sổ bên phải
end, { desc = 'Open vertical terminal on the right' })
