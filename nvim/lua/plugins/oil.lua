return {
    'stevearc/oil.nvim',
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    opts = {
        use_default_keymaps = false,
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-h>"] = false,
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["<C-p>"] = false,
            ["<C-c>"] = { "actions.close", mode = "n" },
            ["<C-l>"] = false,
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        }
    },
}
