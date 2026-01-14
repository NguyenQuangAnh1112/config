return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree", -- Lazy load khi gọi command
	keys = {
		{ "<leader>v", ":Neotree filesystem reveal left<CR>", desc = "Open NeoTree" },
		{ "<leader>xx", ":Neotree filesystem close<CR>", desc = "Close NeoTree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		window = {
			mappings = {
				-- Mở file trong tmux tab mới với phím 't'
				["t"] = function(state)
					local node = state.tree:get_node()
					if node.type == "file" then
						local tmux_tab = require("core.tmux-tab")
						tmux_tab.open_in_new_tmux_window(node.path)
					end
				end,
			},
		},
	},
}
