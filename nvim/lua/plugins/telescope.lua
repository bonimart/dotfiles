return {
	'nvim-telescope/telescope.nvim', branch = 'master',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
	keys = {
		{ '<leader>pf', function () require('telescope.builtin').find_files() end },
		{ '<C-p>', function () require('telescope.builtin').git_files() end },
        { '<leader>ps', function () require('telescope.builtin').live_grep() end },
	},
    lazy=false,
}
