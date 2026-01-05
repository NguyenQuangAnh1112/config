return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			-- Thay thế netrw
			default_file_explorer = true,

			-- Chỉ hiển thị icon (đơn giản, sạch sẽ)
			columns = { "icon" },

			-- Xóa vào thùng rác
			delete_to_trash = true,

			-- Bỏ qua confirm cho các thao tác đơn giản
			skip_confirm_for_simple_edits = true,

			-- View options
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},

			-- Floating window đẹp
			float = {
				padding = 2,
				max_width = 90,
				max_height = 30,
				border = "rounded",
				win_options = { winblend = 0 },
			},

			-- Preview window
			preview = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				border = "rounded",
				win_options = { winblend = 0 },
				update_on_cursor_moved = true,
			},

			-- Keymaps trong oil buffer
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["q"] = "actions.close",
				["<Esc>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
				["gy"] = "actions.copy_entry_path",
			},
		})

		-- ═══════════════════════════════════════════════════════════
		-- 📂 KEYMAPS
		-- ═══════════════════════════════════════════════════════════
		local map = vim.keymap.set

		-- Mở Oil
		map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		map("n", "<leader>o", "<CMD>Oil --float<CR>", { desc = "Open Oil floating" })

		-- Mở Oil tại thư mục hiện tại của file
		map("n", "<leader>O", function()
			require("oil").open(vim.fn.expand("%:p:h"))
		end, { desc = "Open Oil at file's directory" })

		-- Toggle Oil float
		map("n", "<leader>-", function()
			require("oil").toggle_float()
		end, { desc = "Toggle Oil float" })

		-- Mở Oil tại thư mục root của project (tìm .git)
		map("n", "<leader>op", function()
			local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
			if vim.v.shell_error == 0 then
				require("oil").open_float(git_root)
			else
				require("oil").open_float()
			end
		end, { desc = "Open Oil at project root" })

		-- Quick actions
		map("n", "<leader>oc", function()
			require("oil").open_float(vim.fn.stdpath("config"))
		end, { desc = "Open Oil at Neovim config" })

		map("n", "<leader>oh", function()
			require("oil").open_float(vim.fn.expand("~"))
		end, { desc = "Open Oil at Home" })

		map("n", "<leader>od", function()
			require("oil").open_float(vim.fn.expand("~/Downloads"))
		end, { desc = "Open Oil at Downloads" })
	end,
}
