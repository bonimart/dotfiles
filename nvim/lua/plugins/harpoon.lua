return {
	'ThePrimeagen/harpoon',
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = true,
	keys = {
		{ "<leader>ha", function () require('harpoon.mark').add_file() end, desc = "Mark file with harpoon" },
		{ "<leader>hd", function () require('harpoon.mark').rm_file() end, desc = "Unmark file with harpoon" },
		{ "<leader>hn", function () require('harpoon.ui').nav_next() end, desc = "Go to next harpoon mark" },
		{ "<leader>hp", function () require('harpoon.ui').nav_prev() end, desc = "Go to previous harpoon mark" },
		{ "<leader>hl", function () require('harpoon.ui').toggle_quick_menu() end, desc = "Show harpoon marks" },
	},
}
