return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "vimdoc", "c", "lua", "javascript", "python", "markdown", "markdown_inline", "bash" },
          sync_install = false,
	  auto_install = true,
          highlight = {
		  enable = true,
		  additional_vim_regex_highlighting = false,
	  },
        })

    vim.treesitter.language.register('markdown', 'mdx')

    end
}
