local wk = require("which-key")

vim.keymap.set("n", "<leader>cv", ":lua=")

vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

local path_yank = require("utils.path-yank")
wk.add({ "<leader>cy", group = "Copy file path" })
wk.add({ "<leader>cyy", path_yank.copy_local_path, mode = { "n", "v" }, desc = "Copy current path (relative)" })
wk.add({ "<leader>cya", path_yank.copy_absolute_local_path, mode = { "n", "v" }, desc = "Copy current path (absolute)" })
wk.add({ "<leader>cyr", path_yank.copy_remote_path, mode = { "n", "v" }, desc = "Copy current path (as url)" })

wk.add({ "<leader>d", group = "Debug utils" })
wk.add({ "<leader>dl", "Oconsole.log(`<Esc>pf)<Ignore>i,<Space><Esc>p", desc = "log last yank", remap = true })
wk.add({
  "<leader>dr",
  "^dawilet<Space>_tmp<Space>$<BS>=<Space><Esc>lyt;<Ignore>oconsole.log('<Esc>pf)<Ignore>i,<Space>_tmp<Esc>oreturn<Space>_tmp;<Esc>",
  desc = "log return value",
  remap = true,
})
