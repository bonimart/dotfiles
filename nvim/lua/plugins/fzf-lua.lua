return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-p>", "<cmd>FzfLua git_files<cr>" },
    { "<leader>pf", "<cmd>FzfLua files<cr>" },
    { "<leader>ps", "<cmd>FzfLua live_grep<cr>" },
    { "<C-g>", "<cmd>FzfLua live_grep<cr>" },
  },
  opts = { "telescope" },
}
