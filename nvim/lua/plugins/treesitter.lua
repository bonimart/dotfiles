return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        ensure_installed = {
            "python",
            "rust",
            "bash",
            "go",
            "lua",
            "json",
            "yaml",
            "haskell",
            "cpp",
            "hyprlang",
            "ini"
        }
    },
    config = function(_, opts)
        local ts = require("nvim-treesitter")
        ts.install(opts.ensure_installed)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = "*", -- Wildcard allows graceful failing/succeeding based on parser availability
            callback = function(args)
                -- Start treesitter; abort setup if no parser exists for the filetype
                local ok = pcall(vim.treesitter.start, args.buf)
                if not ok then return end

                -- Folds
                vim.opt_local.foldmethod = 'indent'
                vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

                -- Indentation
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
