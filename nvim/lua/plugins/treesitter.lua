return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    -- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#supported-features
    opts = {
        ensure_installed = {
            "python",
            "rust",
            "bash",
        }
    },
    config = function(_, opts)
        TS = require("nvim-treesitter")
        TS.install(opts.ensure_installed)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = opts.ensure_installed,
            callback = function()
                -- syntax highlighting, provided by Neovim
                vim.treesitter.start()
                -- folds, provided by Neovim
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- indentation, provided by nvim-treesitter
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
