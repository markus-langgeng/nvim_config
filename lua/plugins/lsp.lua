return { -- LSP Configuration & Plugins
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
            'folke/neodev.nvim',
            -- Additional lua configuration, makes nvim stuff amazing
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- LSP settings.
            --  This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(_, bufnr)
                -- NOTE: Remember that lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself
                -- many times.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end

                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                local v_lsp_b = vim.lsp.buf
                local builtin = require('telescope.builtin')

                nmap('<leader>rn', v_lsp_b.rename, '[R]e[n]ame')
                nmap('<leader>ca', v_lsp_b.code_action, '[C]ode [A]ction')

                nmap('gd', v_lsp_b.definition, '[G]oto [D]efinition')
                nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
                nmap('gI', v_lsp_b.implementation, '[G]oto [I]mplementation')
                nmap('<leader>D', v_lsp_b.type_definition, 'Type [D]efinition')
                nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
                nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('K', v_lsp_b.hover, 'Hover Documentation')
                nmap('<C-k>', v_lsp_b.signature_help, 'Signature Documentation')

                -- Lesser used LSP functionality
                nmap('gD', v_lsp_b.declaration, '[G]oto [D]eclaration')
                nmap('<leader>wa', v_lsp_b.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', v_lsp_b.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(v_lsp_b.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    v_lsp_b.format()
                end, { desc = 'Format current buffer with LSP' })
            end

            -- Setup mason so it can manage external tooling
            require('mason').setup({
            })

            require('neodev').setup()


            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. They will be passed to
            --  the `settings` field of the server config. You must look up that documentation yourself.
            local servers = {
                -- clangd = {},
                -- gopls = {},
                pyright = {},
                -- rust_analyzer = {},

                tsserver = {},
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                emmet_ls = {
                    filetypes = {
                        "html",
                        "typescript",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "eruby",
                        "php",
                        "blade",
                    }
                },
                phpactor = {},
            }

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach    = on_attach,
                        settings     = servers[server_name],
                    }
                end
            }
        end,
    }
}
