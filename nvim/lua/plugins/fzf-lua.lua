return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-p>", "<cmd>FzfLua files<cr>" },
    { "<C-g>", "<cmd>FzfLua live_grep<cr>" },
  },
  opts = {"telescope"},
}
