local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  if vim.fn.executable("git") == 0 then
    vim.api.nvim_echo({ { "Git is not installed!", "ErrorMsg" } }, true, {})
    os.exit(1)
  end
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- for utils like :CheckCtrl
require("config.jbj_utils")

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Explicitly add Telescope and plenary
    { "nvim-lua/plenary.nvim", lazy = false },
    { "nvim-telescope/telescope.nvim", lazy = false, dependencies = { "nvim-lua/plenary.nvim" } },
    { import = "plugins" },
    -- Debug spec loading
    { "folke/which-key.nvim" }, -- Add a known plugin directly
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = false,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
