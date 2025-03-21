---@alias RootConfig { label: string, fn: fun(): string}
---@alias RootType "workspace" | "git" | "package" | "cwd"

---@type table<RootType, RootConfig>
M = {}

local workspace_root_spec = { "lua", "yarn.lock", "package-lock.json", "pnpm-lock.yaml", "bun.lockb" }

local function workspace_root()
  local pattern_results = LazyVim.root.detectors.pattern(0, workspace_root_spec)
  return pattern_results[1]
end

---@param root_object RootConfig
local function make_callable(root_object)
  setmetatable(root_object, { __call = root_object.fn })
  return root_object
end

---@type RootConfig
M.workspace = make_callable({
  label = "Workspace",
  fn = workspace_root,
})

---@type RootConfig
M.git = make_callable({
  label = "Git",
  fn = LazyVim.root.git,
})

---@type RootConfig
M.package = make_callable({
  label = "Package",
  fn = function()
    local package_root_spec = { "package.json", "Cargo.toml" }
    local pattern_results = LazyVim.root.detectors.pattern(0, package_root_spec)
    return pattern_results[1]
  end,
})

---@type RootConfig
M.cwd = make_callable({
  label = "CWD",
  fn = function()
    return LazyVim.root.detectors.cwd()[1]
  end,
})

return M
