local opt = vim.opt
-- local g = vim.g

opt.hlsearch = false
opt.incsearch = true
opt.showmode = false

opt.clipboard = "unnamedplus"
-- opt.formatoptions:remove "cro"

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true
opt.cursorline = true

-- disable nvim intro
-- shortmess=filnxtToOF

opt.shortmess:append "sI"

opt.guicursor = ""
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- interactive shell
opt.shellcmdflag = "-ic"

opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append "@-@"

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- treesitter fold
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- Disable folding at startup.

opt.mouse = ""
opt.winbar = "%= %f %m %="

-- [[ autocmd & autogroup ]]
local augroup = vim.api.nvim_create_augroup
local on_save_group = augroup('langgeng', { clear = true })
local yank_group = augroup('HighlightYank', {})
local dart_format_group = augroup('DartFormat', { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- Delete trailing space
autocmd({ 'BufWritePre' }, {
    group = on_save_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

autocmd({ 'BufWritePre' }, {
    group = on_save_group,
    pattern = '*',
    command = [[lua vim.lsp.buf.format()]],
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Stop auto comment on new line
autocmd({ 'FileType' }, {
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
    end
})

autocmd({ 'FileType' }, {
    group = dart_format_group,
    pattern = { 'dart' },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
    end
})
