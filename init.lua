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

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- LazyVim config
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},

	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"zipPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"matchit",
				"matchparen",
			},
		},
	},
})

-- import options
pcall(require, "langgeng")

-- Turn on lsp status information
require("fidget").setup({
    window = {
        blend = 0,
    }
})
