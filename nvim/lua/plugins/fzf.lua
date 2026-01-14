return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    local fzf = require("fzf-lua")
    local tmux_tab = require("core.tmux-tab")

    -- Custom action để mở file trong tmux tab mới
    local function open_in_tmux_tab(selected, opts)
      if not selected or #selected == 0 then return end
      local path = require("fzf-lua.path")
      for _, sel in ipairs(selected) do
        -- Sử dụng fzf-lua's path utility để extract đường dẫn file đúng cách
        -- (loại bỏ icon, line number, column, etc.)
        local entry = path.entry_to_file(sel, opts)
        local filepath = entry.path or sel
        -- Fallback: nếu không có path, thử parse thủ công
        if not filepath or filepath == "" then
          -- Strip icon ở đầu (icon thường là 1-4 ký tự unicode + space)
          local stripped = sel:gsub("^[^%w/%.~]+", "")
          filepath = stripped:match("^([^:]+)") or stripped
        end
        tmux_tab.open_in_new_tmux_window(filepath)
      end
    end

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
      -- Thêm action ctrl-t để mở trong tmux tab mới
      actions = {
        files = {
          ["default"] = fzf.actions.file_edit,
          ["ctrl-t"] = open_in_tmux_tab,  -- Mở trong tmux tab mới
          ["ctrl-s"] = fzf.actions.file_split,
          ["ctrl-v"] = fzf.actions.file_vsplit,
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
