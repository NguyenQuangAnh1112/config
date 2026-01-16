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
map("n", "<leader>cf", function() require("conform").format({ async = true }) end, { desc = "Format File" })
map("n", "<leader>cF", function()
  -- Fix all Ruff issues (organize imports + fix lint issues)
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports", "source.fixAll" } },
    apply = true,
  })
end, { desc = "Fix All (Ruff)" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })

-- =========================
-- 🖥️ LSP -> Tmux Tab (mở trong tmux window mới)
-- =========================
local tmux_tab = require("core.tmux-tab")

-- Helper: Lấy position params với position_encoding (fix warning Neovim 0.10+)
local function get_position_params()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    return vim.lsp.util.make_position_params(0, clients[1].offset_encoding)
  end
  return vim.lsp.util.make_position_params()
end

-- Helper: mở definition trong tmux tab mới
map("n", "gtd", function()
  -- Sử dụng LSP để lấy vị trí definition, sau đó mở trong tmux tab mới
  vim.lsp.buf_request(0, "textDocument/definition", get_position_params(), function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify("No definition found", vim.log.levels.WARN)
      return
    end
    local loc = result[1] or result
    local uri = loc.uri or loc.targetUri
    local filepath = vim.uri_to_fname(uri)
    tmux_tab.open_in_new_tmux_window(filepath)
  end)
end, { desc = "Go to Definition in Tmux Tab" })

map("n", "gtD", function()
  vim.lsp.buf_request(0, "textDocument/declaration", get_position_params(), function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify("No declaration found", vim.log.levels.WARN)
      return
    end
    local loc = result[1] or result
    local uri = loc.uri or loc.targetUri
    local filepath = vim.uri_to_fname(uri)
    tmux_tab.open_in_new_tmux_window(filepath)
  end)
end, { desc = "Go to Declaration in Tmux Tab" })

map("n", "gti", function()
  vim.lsp.buf_request(0, "textDocument/implementation", get_position_params(), function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify("No implementation found", vim.log.levels.WARN)
      return
    end
    local loc = result[1] or result
    local uri = loc.uri or loc.targetUri
    local filepath = vim.uri_to_fname(uri)
    tmux_tab.open_in_new_tmux_window(filepath)
  end)
end, { desc = "Go to Implementation in Tmux Tab" })

-- Toggle tmux tab mode
map("n", "<leader>tt", function()
  tmux_tab.toggle()
end, { desc = "Toggle Tmux Tab Mode" })

-- =========================
-- 🔍 Diagnostics
-- =========================
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous Diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

-- =========================
-- 🪟 Window Navigation
-- =========================
-- NOTE: C-hjkl keymaps are defined in tmux.lua for tmux integration
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

-- open web
vim.keymap.set("v", "gw", function()
  local text = vim.fn.getreg("v")
  vim.cmd('silent! normal! ""y')
  local query = vim.fn.getreg('"')
  vim.fn.jobstart({"xdg-open", "https://www.google.com/search?q=" .. query}, {detach = true})
end, { desc = "Search selected text on Google" })

