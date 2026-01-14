-- File: lua/plugins/whichkey.lua
-- Which-Key configuration với tất cả phím tắt được nhóm lại

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
    show_help = true,
    show_keys = true,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- =========================
    -- 📁 GROUP DEFINITIONS
    -- =========================
    wk.add({
      { "<leader>b", group = "📑 Buffer" },
      { "<leader>c", group = "💻 Code" },
      { "<leader>d", group = "🐛 Debug/Diagnostics" },
      { "<leader>f", group = "🔍 Find (FZF)" },
      { "<leader>g", group = "🌿 Git" },
      { "<leader>l", group = "📝 LSP" },
      { "<leader>p", group = "📦 Project" },
      { "<leader>s", group = "🪟 Split" },
      { "<leader>x", group = "❌ Close" },
    })

    -- =========================
    -- 💾 GENERAL
    -- =========================
    wk.add({
      { "<leader>w", ":w<CR>", desc = "💾 Save", mode = "n" },
      { "<leader>q", ":q<CR>", desc = "🚪 Quit", mode = "n" },
      { "<leader>pv", vim.cmd.Ex, desc = "📂 Open netrw", mode = "n" },
      { "<leader>v", ":Neotree filesystem reveal left<CR>", desc = "🌲 Open NeoTree", mode = "n" },
    })

    -- =========================
    -- 📑 BUFFER
    -- =========================
    wk.add({
      { "<leader>bn", ":bnext<CR>", desc = "➡️ Next Buffer", mode = "n" },
      { "<leader>bp", ":bprev<CR>", desc = "⬅️ Previous Buffer", mode = "n" },
      { "<leader>bd", ":bdelete<CR>", desc = "🗑️ Delete Buffer", mode = "n" },
    })

    -- =========================
    -- 🪟 SPLIT/WINDOW
    -- =========================
    wk.add({
      { "<leader>sv", ":vsplit<CR>", desc = "📐 Split Vertical", mode = "n" },
      { "<leader>sh", ":split<CR>", desc = "📏 Split Horizontal", mode = "n" },
      { "<leader>sx", ":close<CR>", desc = "❌ Close Split", mode = "n" },
    })

    -- =========================
    -- ❌ CLOSE
    -- =========================
    wk.add({
      { "<leader>xx", ":Neotree filesystem close<CR>", desc = "🌲 Close NeoTree", mode = "n" },
    })

    -- =========================
    -- 📝 LSP KEYMAPS
    -- =========================
    wk.add({
      { "<leader>lr", vim.lsp.buf.rename, desc = "✏️ Rename Symbol", mode = "n" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "💡 Code Action", mode = "n" },
      { "<leader>lD", vim.lsp.buf.type_definition, desc = "🔍 Type Definition", mode = "n" },
      { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "🎨 Format", mode = "n" },
    })

    -- LSP Go-to (không cần leader)
    wk.add({
      { "gd", vim.lsp.buf.definition, desc = "📍 Go to Definition", mode = "n" },
      { "gD", vim.lsp.buf.declaration, desc = "📍 Go to Declaration", mode = "n" },
      { "gr", vim.lsp.buf.references, desc = "🔗 Find References", mode = "n" },
      { "gi", vim.lsp.buf.implementation, desc = "🔧 Go to Implementation", mode = "n" },
      { "K", vim.lsp.buf.hover, desc = "📖 Hover Documentation", mode = "n" },
    })

    -- =========================
    -- 🔍 DIAGNOSTICS
    -- =========================
    wk.add({
      { "<leader>de", vim.diagnostic.open_float, desc = "🔎 Show Diagnostic", mode = "n" },
      { "<leader>dl", vim.diagnostic.setloclist, desc = "📋 Diagnostic List", mode = "n" },
      { "[d", vim.diagnostic.goto_prev, desc = "⬆️ Previous Diagnostic", mode = "n" },
      { "]d", vim.diagnostic.goto_next, desc = "⬇️ Next Diagnostic", mode = "n" },
    })


    -- =========================
    -- 🔍 FZF KEYMAPS
    -- =========================
    local fzf_ok, fzf = pcall(require, "fzf-lua")
    if fzf_ok then
      wk.add({
        -- Files
        { "<leader>ff", fzf.files, desc = "📁 Find Files", mode = "n" },
        { "<leader>fo", fzf.oldfiles, desc = "📜 Recent Files", mode = "n" },
        { "<leader>fr", fzf.resume, desc = "🔄 Resume Last Search", mode = "n" },
        -- Grep
        { "<leader>fg", fzf.live_grep, desc = "🔎 Live Grep", mode = "n" },
        { "<leader>fG", function()
          fzf.live_grep({
            rg_opts = "--hidden --glob '!.git/*' --column --line-number --no-heading --color=always -e",
          })
        end, desc = "🔎 Live Grep (hidden)", mode = "n" },
        { "<leader>fw", fzf.grep_cword, desc = "🔤 Grep Word Under Cursor", mode = "n" },
        { "<leader>fs", function()
          fzf.grep({ search = vim.fn.input("Grep For > ") })
        end, desc = "📝 Grep with Input", mode = "n" },
        -- LSP Symbols
        { "<leader>fd", fzf.lsp_document_symbols, desc = "📋 Document Symbols", mode = "n" },
        { "<leader>fD", fzf.lsp_workspace_symbols, desc = "🌐 Workspace Symbols", mode = "n" },
        -- Buffers & Help
        { "<leader>fb", fzf.buffers, desc = "📑 Buffers", mode = "n" },
        { "<leader>fh", fzf.help_tags, desc = "❓ Help Tags", mode = "n" },
        { "<leader>fC", fzf.commands, desc = "⌨️ Commands", mode = "n" },
        { "<leader>fk", fzf.keymaps, desc = "🎹 Keymaps", mode = "n" },
        -- Find class
        { "<leader>fc", function()
          local word = vim.fn.expand("<cword>")
          fzf.grep({
            search = "class " .. word,
            rg_opts = "--type py --glob '!__pycache__/*'",
          })
        end, desc = "🐍 Find Python Class", mode = "n" },
      })

      -- Visual mode
      wk.add({
        { "<leader>fw", fzf.grep_visual, desc = "🔤 Grep Visual Selection", mode = "v" },
      })
    end

    -- =========================
    -- 📦 PROJECT (Git files)
    -- =========================
    if fzf_ok then
      wk.add({
        { "<leader>pf", fzf.git_files, desc = "📂 Git Files", mode = "n" },
      })
    end

    -- =========================
    -- 🌿 GIT (Gitsigns)
    -- =========================
    wk.add({
      { "<leader>gs", desc = "📥 Stage hunk", mode = "n" },
      { "<leader>gr", desc = "↩️ Reset hunk", mode = "n" },
      { "<leader>gS", desc = "📥 Stage buffer", mode = "n" },
      { "<leader>gu", desc = "⏪ Undo stage hunk", mode = "n" },
      { "<leader>gR", desc = "↩️ Reset buffer", mode = "n" },
      { "<leader>gp", desc = "👀 Preview hunk", mode = "n" },
      { "<leader>gb", desc = "👤 Blame line", mode = "n" },
      { "<leader>gB", desc = "👤 Toggle line blame", mode = "n" },
      { "<leader>gd", desc = "📊 Diff this", mode = "n" },
      { "<leader>gD", desc = "📊 Diff this ~", mode = "n" },
    })

    -- =========================
    -- 🪟 WINDOW NAVIGATION
    -- =========================
    wk.add({
      { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", desc = "⬅️ Move Left", mode = "n" },
      { "<C-j>", "<Cmd>TmuxNavigateDown<CR>", desc = "⬇️ Move Down", mode = "n" },
      { "<C-k>", "<Cmd>TmuxNavigateUp<CR>", desc = "⬆️ Move Up", mode = "n" },
      { "<C-l>", "<Cmd>TmuxNavigateRight<CR>", desc = "➡️ Move Right", mode = "n" },
    })
  end,
}
