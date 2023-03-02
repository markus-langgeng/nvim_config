local vk = vim.keymap

vk.set("n", "<leader>D", vim.cmd.Ex, { desc = "Open up Netrw" })

vk.set("v", "J", ":m '>+1<CR>gv=gv")
vk.set("v", "K", ":m '<-2<CR>gv=gv")

vk.set("n", "J", "mzJ`z")
vk.set("n", "<C-d>", "<C-d>zz")
vk.set("n", "<C-u>", "<C-u>zz")
vk.set("n", "n", "nzzzv")
vk.set("n", "N", "Nzzzv")

vk.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vk.set({ "n", "v" }, "<leader>y", [["+y]])
vk.set("n", "<leader>Y", [["+Y]])
vk.set("v", ">", ">gv")
vk.set("v", "<", "<gv")

vk.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vk.set("i", "jk", "<Esc>")

vk.set("n", "Q", "<nop>")
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- keymap.set("n", "<leader>f", vim.lsp.buf.format)

vk.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vk.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vk.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vk.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vk.set("n", "<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vk.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vk.set("n", "<leader><leader>s", "<cmd>source %<CR>")

vk.set("n", "<leader>ox", function()
    local path = vim.fn.input("Open Explorer in > ", "~", "file")
    if (path == nil or path == '') then return end
    vim.fn.system(string.format('explorer.exe `wslpath -w "%s"`', path))
end, { desc = "[O]pen File E[X]plorer from nvim" })

-- Diagnostic keymaps
vk.set('n', '[d', vim.diagnostic.goto_prev)
vk.set('n', ']d', vim.diagnostic.goto_next)
vk.set('n', '<leader>e', vim.diagnostic.open_float)
vk.set('n', '<leader>q', vim.diagnostic.setloclist)
