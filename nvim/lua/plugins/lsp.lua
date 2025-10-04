return {
    {
        'mason-org/mason.nvim',
        opts = {}
    },
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                'ruff',
                'pyright'
            }
        },
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function()
            vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            return {
                sources = {
                    { name = 'nvim_lsp' },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>']  = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
            }
        end,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp'
        },
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
            })
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    opts = { buffer = ev.buf, remap = false }
                    vim.keymap.set("n", "gd",  vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d",  vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "]d",  vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                end,
            })
            local auto_format = vim.api.nvim_create_augroup("AutoFormat", { clear = false })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.py" },
                group = auto_format,
                callback = function(ev)
                    vim.lsp.buf.code_action({
                        context = { only = { "source.fixAll.ruff" } },
                        apply = true,
                    })
                    vim.lsp.buf.code_action({
                        context = { only = { "source.organizeImports" } },
                        apply = true,
                    })
                    vim.lsp.buf.format { async = true }
                end,
            })
        end
    },
}
