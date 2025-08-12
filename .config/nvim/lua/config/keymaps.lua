-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = true }) -- move to end of line in insert mode
vim.keymap.set("n", "<C-e>", "<End>", { noremap = true, silent = true }) -- move to end of line in insert mode

vim.keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting the default register" })
vim.keymap.set("n", "<leader>dt", "<cmd>diffthis<CR>", { desc = "Diff This" })

-- jbj keys
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save File", noremap = true, silent = true })
-- terminal mode
vim.keymap.set("t", "<C-;>", "<C-\\><C-n>", { noremap = true, silent = true })
-- Move line(s) up
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true, noremap = true })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
-- Move line(s) down
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true, noremap = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })

-- clear keybinds --
vim.keymap.del("n", "<leader>bb") -- Remove default <leader>bb mapping
vim.keymap.del("n", "<leader>ff") -- Remove default <leader>bb mapping

-- set keybinds for yazi, buffer list, find files
vim.keymap.set("n", "<leader>--", "<cmd>Yazi toggle<cr>", { desc = "Yazi Toggle" })

-- <leader> bl to switch to last buffer
vim.keymap.set("n", "<leader>bl", "<cmd>e #<cr>", { desc = "Switch to last buffer" })

-- find all files within $HOME
vim.keymap.set("n", "<leader>fa", function()
  local builtin = require("telescope.builtin")
  return builtin.find_files({
    find_command = { "rg", "--files", "--hidden", "-g", "!.git/" },
    cwd = "~/",
  })
end, { desc = "Find any file within $HOME" })
-- find all files within current directory, including hidden
vim.keymap.set("n", "<leader>ff", function()
  require("snacks.picker").files({ hidden = true, nofile = false, initial_mode = "normal" })
end, { desc = "Files (all, cwd)" })
-- find all files within current directory, filter out hidden and directories
vim.keymap.set("n", "<leader>bb", function()
  require("snacks.picker").buffers({ hidden = false, nofile = false, initial_mode = "normal" })
end, { desc = "Buffers (filtered)" })

-- find all files within current directoy, exclude hidden.
vim.keymap.set("n", "<leader>fh", function()
  local builtin = require("telescope.builtin")
  return builtin.find_files({ find_command = { "rg", "--files", "-g", "!.git/" } })
end, { desc = "Find exclude hidden" })
