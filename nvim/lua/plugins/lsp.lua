return {
    'VonHeikemen/lsp-zero.nvim',

    branch = 'v4.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    },
    config = function ()
        local lsp = require("lsp-zero")

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'rust_analyzer',
                'lua_ls',
                'vimls',
                'mdx_analyzer',
                'bashls',
                'pylsp'
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                pylsp = function()
                    require('lspconfig').pylsp.setup({
                        settings = {
                            pylsp = {
                                plugins = {
                                    ruff = {
                                        enabled = true,
                                        formatEnabled = true
                                    },
                                    mypy = {
                                        enabled = true,
                                        live_mode = true
                                    }
                                }
                            }
                        }
                    })
                end,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {'vim'}
                                }
                            }
                        }
                    })
                end
            }
        })

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        cmp.setup({
            sources = {
                {name = 'nvim_lsp'}
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end
            },
            mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil
            }
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = 'E',
                    [vim.diagnostic.severity.WARN] = 'W',
                    [vim.diagnostic.severity.INFO] = 'I',
                    [vim.diagnostic.severity.HINT] = 'H'
                }
            }
        })


        lsp.on_attach(function(_, bufnr)
            local opts = {buffer = bufnr, remap = false}

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        lsp.format_on_save({
            servers = {
                ['pylsp'] = {'python'}
            }
        })

    end,
}
