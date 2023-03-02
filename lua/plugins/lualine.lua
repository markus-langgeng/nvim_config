return {
    {
        'nvim-lualine/lualine.nvim', -- Fancier statusline
        event = 'VeryLazy',
        opts = {
            options = {
                icons_enabled = true,
                theme = 'iceberg_dark',
                -- theme = 'palenight',
                component_separators = '|',
                section_separators = '',
                globalstatus = true,
            },
        },
    },
    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },
}
