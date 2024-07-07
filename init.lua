vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set scrolloff=8")
vim.cmd("set guicursor=i:block")

vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
local opts = {}
require("lazy").setup("plugins")
local builtin = require("telescope.builtin")

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

--keymaps
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>e', ':Neotree<CR>', {})

vim.keymap.set('n', '<leader>a', harpoon_mark.add_file, {})
vim.keymap.set('n', '<leader>l', harpoon_ui.toggle_quick_menu, {})

-- Window navigation
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', {})
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', {})
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', {})
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', {})

-- Window resize
vim.keymap.set('n', '<C-z>', ':vertical resize -2<CR>', {})
vim.keymap.set('n', '<C-x>', ':vertical resize +2<CR>', {})


-- Treesitter config
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "rust", "vim", "python"},
  highlight = { enable = true },
  indent = { enable = true },
})

-- Colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
