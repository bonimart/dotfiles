return {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ '<leader>pf', function () require('telescope.builtin').find_files() end },
		{ '<C-p>', function () require('telescope.builtin').git_files() end },
        { '<leader>ps', function () require('telescope.builtin').live_grep() end },
	},
    lazy=false,
}
