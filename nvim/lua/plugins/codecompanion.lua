return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    opts = {
        -- NOTE: The log_level is in `opts.opts`
        opts = {
            log_level = "DEBUG",
        },
    },
    keys = {
        { "<leader>a", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle CodeCompanion chat" },
        { "<C-a>", "<cmd>CodeCompanionActions<CR>", desc = "Select one of CodeCompanion actions" },
        { "ga", "<cmd>CodeCompanionChat Add<CR>", remap = true, mode = {"v"}, desc = "Add selection to CodeCompanion chat" },
    }
}
