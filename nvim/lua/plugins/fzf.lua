return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    local fzf = require("fzf-lua")

    -- =========================
    -- ⚙️ SETUP
    -- =========================
    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.90,
        preview = { layout = "horizontal" },
      },
      fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1",
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    })

    -- =========================
    -- 🔍 FILE / PROJECT
    -- =========================
    vim.keymap.set("n", "<leader>ff", fzf.files,
      { desc = "FZF: Find files" })

    vim.keymap.set("n", "<leader>pf", fzf.git_files,
      { desc = "FZF: Git files" })

    vim.keymap.set("n", "<leader>fr", fzf.resume,
      { desc = "FZF: Resume last search" })

    -- =========================
    -- 🔎 GREP / SEARCH
    -- =========================
    vim.keymap.set("n", "<leader>fg", fzf.live_grep,
      { desc = "FZF: Live grep" })

    vim.keymap.set("n", "<leader>fG", function()
      fzf.live_grep({
        rg_opts =
          "--hidden --glob '!.git/*' --column --line-number --no-heading --color=always -e",
      })
    end, { desc = "FZF: Live grep (hidden)" })

    vim.keymap.set("n", "<leader>fw", fzf.grep_cword,
      { desc = "FZF: Grep word under cursor" })

    vim.keymap.set("v", "<leader>fw", fzf.grep_visual,
      { desc = "FZF: Grep visual selection" })

    vim.keymap.set("n", "<leader>fs", function()
      fzf.grep({ search = vim.fn.input("Grep For > ") })
    end, { desc = "FZF: Grep with input" })

    -- =========================
    -- 🧠 SYMBOLS (LSP qua fzf)
    -- =========================
    vim.keymap.set("n", "<leader>fd", fzf.lsp_document_symbols,
      { desc = "FZF: Document symbols" })

    vim.keymap.set("n", "<leader>fD", fzf.lsp_workspace_symbols,
      { desc = "FZF: Workspace symbols" })

    -- =========================
    -- 🧾 BUFFERS / HISTORY
    -- =========================
    vim.keymap.set("n", "<leader>fb", fzf.buffers,
      { desc = "FZF: Buffers" })

    vim.keymap.set("n", "<leader>fo", fzf.oldfiles,
      { desc = "FZF: Recent files" })

    -- =========================
    -- 🆘 HELP / COMMANDS
    -- =========================
    vim.keymap.set("n", "<leader>fh", fzf.help_tags,
      { desc = "FZF: Help tags" })

    vim.keymap.set("n", "<leader>fC", fzf.commands,
      { desc = "FZF: Commands" })

    vim.keymap.set("n", "<leader>fk", fzf.keymaps,
      { desc = "FZF: Keymaps" })

    -- =========================
    -- 🎯 FIND CLASS (fzf thay gd khi LSP fail)
    -- =========================
    vim.keymap.set("n", "<leader>fc", function()
      local word = vim.fn.expand("<cword>")
      require("fzf-lua").grep({
        search = "class " .. word,
        rg_opts = "--type py --glob '!__pycache__/*'",
      })
    end, { desc = "FZF: Find class definition" })
  end,
}
