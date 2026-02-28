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
                'ty',
                'gopls',
            }
        },
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = {
                    -- To fix auto-fixable lint errors.
                    "ruff_fix",
                    -- To run the Ruff formatter.
                    "ruff_format",
                    -- To organize the imports.
                    "ruff_organize_imports",
                },
                go = { "goimports", "gofmt" }
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "last",
            },
        }
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
                    ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>']      = cmp.mapping.confirm({ select = true }),
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
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                end,
            })
        end
    },
}
