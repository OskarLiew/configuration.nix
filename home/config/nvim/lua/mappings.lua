-- Jumping around
vim.keymap.set("n", "<n>", "nzzzv")
vim.keymap.set("n", "<N>", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half page up and center" })
vim.keymap.set("n", "<A-n>", "<cmd> cnext <CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<A-p>", "<cmd> cprev <CR>zz", { desc = "Previous quickfix item" })
vim.keymap.set("n", "]l", "<cmd> lnext <CR>zz", { desc = "Next loclist item" })
vim.keymap.set("n", "[l", "<cmd> lprev <CR>zz", { desc = "Previous loclist item" })

-- Switching windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>h", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>h", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>h", { desc = "Window right" })

-- navigate within insert mode
vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

vim.keymap.set("n", "<Esc>", ":noh <CR>", { desc = "Clear highlights" })

-- save
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

-- yank / paste
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank row to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Don't copy replaced text" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })

vim.keymap.set("v", "<", "<gv", { desc = "Deindent line" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent line" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
