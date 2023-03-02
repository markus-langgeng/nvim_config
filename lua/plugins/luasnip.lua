return { -- Snippets
    'L3MON4D3/LuaSnip',
    dependencies = {
        'rafamadriz/friendly-snippets',
        config = function ()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    opts = {
        -- This tells LuaSnip to remember to keep around the last snippet.
        -- You can jump back into it even if you move outside of the selection
        history = true,
        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        update_events = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
        delete_check_events = 'TextChanged',
    },
    keys = {
        {'<C-k>', function ()
            local ls = require('luasnip')
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end,
            expr = true,
            silent = true,
            mode = {'i', 's'},
        },
        {'<C-j>', function ()
            local ls = require('luasnip')
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end,
            expr = true,
            silent = true,
            mode = {'i', 's'},
        },
    },
}
