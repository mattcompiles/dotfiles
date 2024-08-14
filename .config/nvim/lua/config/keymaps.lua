vim.keymap.set("n", "<leader>cv", ":lua=")

vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

local path_yank = require("utils.path-yank")
vim.keymap.set({ "n", "v" }, "<leader>cy", path_yank.copy_path, { desc = "Copy current path" })
