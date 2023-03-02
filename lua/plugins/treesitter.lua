return { -- Highlight, edit, and navigate code
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = true,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
        event = 'BufReadPost',
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Shrink selection", mode = "v" },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        opts = {
            ensure_installed = {
                'lua',
                'python',
                'typescript',
                'help',
                'vim',
                'html',
                'css',
                'scss',
                'latex',
                'comment',
                'diff',
                'regex',
                'markdown',
            },
            highlight = { enable = true },
            indent = { enable = true, disable = { 'python' } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    node_decremental = '<bs>',
                    scope_incremental = '<c-s>',
                },
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        },
        config = function (_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
}

