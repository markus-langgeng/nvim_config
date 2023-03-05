-- return {
--     'rebelot/kanagawa.nvim',
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--         vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
--         require('kanagawa').setup({
--             transparent = true,
--             globalStatus = true,
--             overrides = {
--                 WinSeparator = { fg = "#223249" }
--             }
--         })
--         vim.cmd([[colorscheme kanagawa]])
--     end,
-- }

return {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
        require('catppuccin').setup({
            transparent_background = true,
            term_colors = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                telescope = true,
                mason = true,
                treesitter = true,
                treesitter_context = true,
                harpoon = true,

                -- special
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                }
            },
        })
        vim.cmd([[colorscheme catppuccin]])
    end,
}
