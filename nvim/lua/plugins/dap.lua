return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
        },
        keys = function()
            local dap = require("dap")
            return {
                -- stylua: ignore start
                { "<leader>d", group = "  Debug" },
                { "<leader>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args", },
                { "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition", },
                { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint", },
                { "<leader>dc", function() dap.continue() end, desc = "Continue", },
                { "<leader>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor", },
                { "<leader>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)", },
                { "<leader>di", function() dap.step_into() end, desc = "Step Into", },
                { "<leader>dk", function() dap.down() end, desc = "Down", },
                { "<leader>dl", function() dap.up() end, desc = "Up", },
                { "<leader>dl", function() dap.run_last() end, desc = "Run Last", },
                { "<leader>dO", function() dap.step_out() end, desc = "Step Out", },
                { "<leader>do", function() dap.step_over() end, desc = "Step Over", },
                { "<leader>dp", function() dap.pause() end, desc = "Pause", },
                { "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle REPL", },
                { "<leader>dt", function() dap.terminate() end, desc = "Terminate", },
                { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets", },
                { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python", },
                { "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python", },
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = function()
            return {
                -- stylua: ignore start
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",   mode = { "n", "v" }, },
            }
        end,
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        keys = {
            { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
            { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
        },
        config = function()
            require("dap-python").setup("uv")
        end,
    }
}
