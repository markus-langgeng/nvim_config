return {
    'nvim-telescope/telescope.nvim',
    version = false, -- last release is way too old and doesn't work on Windows
    cmd = "Telescope",
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end
        },
    },
    keys = {
        -- [[ Default Kickstart mapping ]]
        -- See `:help telescope.builtin`
        { '<leader>?',       "<cmd>Telescope oldfiles<CR>", desc = '[?] Find recently opened files' },
        { '<leader><space>', "<cmd>Telescope buffers<CR>",  desc = '[ ] Find existing buffers' },
        { '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                -- winblend = 10,
                previewer = false,
            })
        end, desc = '[/] Fuzzily search in current buffer]' },

        { '<leader>sf',  "<cmd>Telescope find_files<CR>",  desc = '[S]earch [F]iles' },
        { '<leader>sh',  "<cmd>Telescope help_tags<CR>",   desc = '[S]earch [H]elp' },
        { '<leader>sw',  "<cmd>Telescope grep_string<CR>", desc = '[S]earch current [W]ord' },
        { '<leader>sg',  "<cmd>Telescope live_grep<CR>",   desc = '[S]earch by [G]rep' },
        { '<leader>sd',  "<cmd>Telescope diagnostics<CR>", desc = '[S]earch [D]iagnostics' },

        -- [[ My mapping ]]
        { '<C-p>',       ':Telescope ',                    desc = 'Write :Telescope on the command prompt' },
        { '<leader>sgt', "<cmd>Telescope git_files<CR>",   desc = '[S]earch [G]i[T] files' },
        { '<leader>scf',
            function()
                require('telescope.builtin').find_files({ cwd = '~/.config/nvim' })
            end,
            desc = '[S]earch nvim [C]on[F]ig files' },
        { '<leader>sop', "<cmd>Telescope vim_options<CR>", desc = '[S]earch all [OP]tions' },
        { '<leader>scm', "<cmd>Telescope commands<CR>",    desc = '[S]earch [C]o[M]mand' },
        { '<leader>skm', "<cmd>Telescope keymaps<CR>",     desc = '[S]earch [K]eymaps' },
        { '<leader>shl', "<cmd>Telescope highlights<CR>",  desc = '[S]earch [H]ighlights' },
        { '<leader>scp',
            function()
                require('telescope.builtin').find_files({ cwd = vim.fn.input('Search on dir > ', '~', 'dir') })
            end,
            desc = '[S]earch + [C]hange directory to specified [P]ath' },
    },
    opts = {
        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        defaults = {
            path_display = { shorten = { len = 1, } },
            preview = {
                treesitter = true,
            },
            dynamic_preview_title = true,
            file_ignore_patterns = {
                'node%_modules/.*',
                'vendor/.*',
                '.git/',
                '%.jpg',
                '%.jpeg',
                '%.png',
                -- '%.otf',
                -- '%.ttf',
                'gradle/.*',
            },
            mappings = {
                i = {
                    ["<a-h>"] = function()
                        require('telescope.builtin').find_files({ hidden = true })
                    end,
                },
            },
        },

        pickers = {
            buffers = {
                mappings = {
                    i = {
                        ['<a-d>'] = function(prompt_bufnr)
                            local selection = require('telescope.actions.state').get_selected_entry()
                            local file_bufnr = selection.bufnr
                            require('telescope.actions').close(prompt_bufnr)
                            vim.cmd(string.format('silent bd %d', file_bufnr))
                        end,
                    }
                }
            }
        }

    },
}
