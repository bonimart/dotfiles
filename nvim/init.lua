require("boni")

-- https://askubuntu.com/questions/1486871/how-can-i-copy-and-paste-outside-of-neovim
vim.api.nvim_set_option("clipboard", "unnamed")

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- lazy.nvim

vim.cmd.colorscheme "catppuccin"
