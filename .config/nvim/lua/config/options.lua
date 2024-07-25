-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_picker = "fzf"
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

local workspace_root_spec = { "yarn.lock", "package-lock.json", "pnpm-lock.yaml", "bun.lockb" }
local workspace_root_spec = { "yarn.lock", "package-lock.json", "pnpm-lock.yaml", "bun.lockb", "lua" }

vim.g.workspace_root = function()
  local pattern_results = LazyVim.root.detectors.pattern(0, workspace_root_spec)
  return pattern_results[1]
end

local package_root_spec = { "package.json", "cargo.toml" }

vim.g.package_root = function()
  local pattern_results = LazyVim.root.detectors.pattern(0, package_root_spec)
  return pattern_results[1]
end
