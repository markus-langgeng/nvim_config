return {
    'rebelot/kanagawa.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('kanagawa').setup({
            transparent = true,
            globalStatus = true,
            overrides = function() -- add/modify highlights
                return {
                    WinSeparator = { fg = "#223249", bg = "none" },
                    LineNr = { bg = "none" },
                    SignColumn = { bg = "none" },
                    CursorLine = { bg = "none" },
                    CursorLineNr = { bg = "none" },
                    TelescopeBorder = { bg = "none" },
                    -- git signs
                    -- ref: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/gitsigns.lua
                    GitSignsAdd = { bg = "none" }, -- diff mode: Added line |diff.txt|
                    GitSignsChange = { bg = "none" }, -- diff mode: Changed line |diff.txt|
                    GitSignsDelete = { bg = "none" }, -- diff mode: Deleted line |diff.txt|
                    GitSignsAddPreview = { bg = "none" },
                    GitSignsDeletePreview = { bg = "none" },
                    -- diagnostics
                    DiagnosticSignHint = { bg = "none" },
                    DiagnosticSignInfo = { bg = "none" },
                    DiagnosticSignWarn = { bg = "none" },
                    DiagnosticSignError = { bg = "none" },
                }
            end,
        })
        -- kanagawa-wave, kanagawa-dragon, kanagawa-lotus
        vim.cmd([[colorscheme kanagawa-wave]])
    end,
}

-- return {
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     config = function()
--         require('catppuccin').setup({
--             transparent_background = true,
--             term_colors = true,
--             integrations = {
--                 cmp = true,
--                 gitsigns = true,
--                 telescope = true,
--                 mason = true,
--                 treesitter = true,
--                 treesitter_context = true,
--                 harpoon = true,
--
--                 -- special
--                 native_lsp = {
--                     enabled = true,
--                     virtual_text = {
--                         errors = { "italic" },
--                         hints = { "italic" },
--                         warnings = { "italic" },
--                         information = { "italic" },
--                     },
--                     underlines = {
--                         errors = { "underline" },
--                         hints = { "underline" },
--                         warnings = { "underline" },
--                         information = { "underline" },
--                     },
--                 }
--             },
--         })
--         vim.cmd([[colorscheme catppuccin]])
--     end,
-- }
