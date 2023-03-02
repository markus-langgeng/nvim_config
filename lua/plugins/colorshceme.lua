return {
    'rebelot/kanagawa.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
        require('kanagawa').setup({
            transparent = true,
            globalStatus = true,
            overrides = {
                WinSeparator = { fg = "#223249" }
            }
        })
        vim.cmd([[colorscheme kanagawa]])
    end,
}
