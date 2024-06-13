return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      path_display = { "truncate" },
    },
  },
  keys = {
    -- disable the keymap to grep files
    -- { "<leader>/", false },
    -- change a keymap
    { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent (all)" },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ search_file = "package.json" })
      end,
      desc = "Find packages",
    },
    {
      "<leader>fn",
      function()
        require("telescope.builtin").find_files({
          no_ignore = true,
          search_dirs = { "node_modules" },
          search_file = "package.json",
        })
      end,
      desc = "Find node_module",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").find_files({
          no_ignore = true,
          search_dirs = { "build", "jira/build" },
        })
      end,
      desc = "Find build files",
    },
  },
}
