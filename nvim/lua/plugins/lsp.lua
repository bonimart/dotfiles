return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
    },
    config = function()
        -- Mason
        require('mason').setup({})

        -- LSP capabilities (so cmp works with LSP)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Shared on_attach: mappings and format-on-save
        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "gd",  vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K",   vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d",  vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "]d",  vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
            vim.keymap.set("i",  "<C-h>", vim.lsp.buf.signature_help, opts)
        end

        -- Diagnostics config
        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = 'E',
                    [vim.diagnostic.severity.WARN]  = 'W',
                    [vim.diagnostic.severity.INFO]  = 'I',
                    [vim.diagnostic.severity.HINT]  = 'H',
                },
            },
        })

        -- Mason-lspconfig: ensure and set up servers
        require('mason-lspconfig').setup({
            ensure_installed = {
                'rust_analyzer',
                'lua_ls',
                'vimls',
                'mdx_analyzer',
                'bashls',
                'pyright',
                'ruff',
                'yamlls',
                'helm_ls',
            },
        })

        local lspconfig = require('lspconfig')

        -- Default handler
        local function setup_default(server)
            lspconfig[server].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end

        -- Apply default to all installed servers unless overridden
        require('mason-lspconfig').setup_handlers({
            setup_default,

            -- pyright with custom settings
            pyright = function()
                lspconfig.pyright.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        pyright = {
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                ignore = { "*" }, -- mirrors your current config
                            },
                        },
                    },
                })
            end,

            -- lua_ls with global 'vim' diagnostic
            lua_ls = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' },
                            },
                        },
                    },
                })
            end,

            -- helm_ls with yamlls path override
            helm_ls = function()
                lspconfig.helm_ls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        ['helm-ls'] = {
                            yamlls = {
                                path = "yaml-language-server",
                            },
                        },
                    },
                })
            end,

            ruff = function()
                lspconfig.ruff.setup({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        -- Only wire save hooks if Ruff can act on this buffer
                        local supports_format = client.supports_method("textDocument/formatting")
                        local supports_actions = client.supports_method("textDocument/codeAction")

                        -- Scope to Python buffers
                        if vim.bo[bufnr].filetype ~= "python" then
                            return
                        end

                        local group = vim.api.nvim_create_augroup("ruff.on_save." .. bufnr, { clear = true })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = group,
                            buffer = bufnr,
                            callback = function()
                                -- 1) Fix all autofixable issues (ruff)
                                if supports_actions then
                                    pcall(vim.lsp.buf.code_action, {
                                        context = { only = { "source.fixAll.ruff" } },
                                        apply = true,
                                    })
                                    -- 2) Organize imports (ruff)
                                    pcall(vim.lsp.buf.code_action, {
                                        context = { only = { "source.organizeImports.ruff", "source.organizeImports" } },
                                        apply = true,
                                    })
                                end
                                -- 3) Format with Ruff
                                if supports_format then
                                    vim.lsp.buf.format({
                                        async = false,
                                        bufnr = bufnr,
                                        timeout_ms = 1500,
                                    })
                                end
                            end,
                        })
                    end,
                })
            end,
        })

        -- nvim-cmp (keeps your sources/snippet behavior; fill in your mappings)
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body) -- using built-in snippets as in your file
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Choose concrete keys; your original had empty strings
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>']  = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })
    end,
}
