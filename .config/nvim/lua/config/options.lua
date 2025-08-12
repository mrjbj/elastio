-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"
vim.g.lazygit_config = false
vim.g.snacks_animate = true
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.o.timeoutlen = 300
vim.opt.autoread = true

-- Explicitly set leader key
vim.g.mapleader = " " -- Space as leader key
vim.g.maplocalleader = ","

-- vim.g.neovide_normal_opacity = 0.8
-- vim.g.neovim_opacity = 0.8
vim.g.neovide_confirm_quit = true
