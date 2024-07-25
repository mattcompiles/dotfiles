-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_picker = "fzf"
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

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

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          -- This is the actually useful one
          closingBraceHints = { enable = true, minLines = 10 },
          -- All the rest should be turned off
          bindingModeHints = { enable = false },
          chainingHints = { enable = false },
          closureCaptureHints = { enable = false },
          closureReturnTypeHints = { enable = "never" },
          discriminantHints = { enable = "never" },
          expressionAdjustmentHints = { enable = "never", hideOutsideUnsafe = true },
          genericParameterHints = {
            const = { enable = false },
            lifetime = { enable = false },
            type = { enable = false },
          },
          implicitDrops = { enable = false },
          lifetimeElisionHints = { enable = "never" },
          parameterHints = { enable = false },
          rangeExclusiveHints = { enable = false },
          typeHints = { enable = false, hideClosureInitialization = false, hideNamedConstructor = false },
        },
      },
    },
  },
}
