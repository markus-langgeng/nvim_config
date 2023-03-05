return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        "hrsh7th/cmp-buffer",
        'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
        local cmp = require("cmp")
        return {
            completion = {
                completeopt = 'menu,menuone,noselect'
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs( -4),
                ['<C-u>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-c>'] = cmp.mapping.abort(),
                ['<C-y>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true, select
                },
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lua' },
                { name = 'path' },
                { name = 'buffer',  keyword_length = 4 },
            }),
            formatting = {
                --[[ formatting = function(_, item)
                    local icons = require("lazyvim.config").icons.kinds
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
                    end
                    return item
                end, ]]
                formatting = {
                    buffer = '[buf]',
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[api]',
                    path = '[path]',
                    luasnip = '[snip]',
                },
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }
    end,
}
