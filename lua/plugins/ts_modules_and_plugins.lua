return {
    -- Treesitter Modules
    { -- xml and html autotag
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        config = function ()
            require('nvim-ts-autotag').setup()
        end
    },
    { -- match tags
        'andymass/vim-matchup', event = 'VeryLazy'
    },

    -- Treesitter Plugins
    { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },

    -- Vim blade plugin
    {
        'jwalton512/vim-blade',
        ft = 'blade',
    },

    -- miscellanious
    { -- comment
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = {
            pre_hook = function ()
                require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
            end
        },
        config = function (_, opts)
            require('Comment').setup(opts)
        end
    },
    { 'AndrewRadev/splitjoin.vim', event = 'VeryLazy' },
    { -- close brackets and parentheses
        'rstacruz/vim-closer', event = 'VeryLazy'
    },
}
