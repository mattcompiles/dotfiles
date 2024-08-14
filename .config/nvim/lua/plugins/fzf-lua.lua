local root_selectors = require("config.root_selectors")

return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", LazyVim.pick("files"), desc = "Find files - Git" },
      {
        "<leader>ff",
        function()
          LazyVim.pick("files", { cwd = root_selectors.package() })()
        end,
        desc = "Find files - Package",
      },
      {
        "<leader>fF",
        function()
          LazyVim.pick("files", { cwd = root_selectors.workspace() })()
        end,
        desc = "Find files - Workspace root",
      },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = LazyVim.root.git() }), desc = "Recent files" },
      { "<leader>fR", false },
      {
        "<leader>fn",
        function()
          LazyVim.pick("files", { cwd = vim.fs.joinpath(root_selectors.workspace(), "node_modules") })()
        end,
        desc = "Find node_modules",
      },
      {
        "<leader>fb",
        function()
          LazyVim.pick("files", { cwd = vim.fs.joinpath(root_selectors.workspace(), "build") })()
        end,
        desc = "Find files - Build",
      },
      {
        "<leader>fp",
        function()
          local cmd_string = string.format(
            'rg \z
              \'"name": "(.+)"\' \z
              -g "package.json" \z
              -r \'$1\' \z
              %s \z
              --no-heading \z
              --no-line-number \z
              --trim \z
              --max-count=1',
            LazyVim.root.git()
          )

          require("fzf-lua").fzf_exec(cmd_string, {
            fzf_opts = { ["--delimiter"] = ":", ["--with-nth"] = 2 },
            fn_transform = function(input)
              return string.sub(input, 1, -2)
            end,
            actions = {
              ["default"] = function(selection, opts)
                local package_path = string.gmatch(selection[1], "(.+):(.+)")()
                require("fzf-lua.actions").file_switch_or_edit({ package_path }, opts)
              end,
            },
          })
        end,
        desc = "Find packages",
      },
      {
        "<leader>sg",
        LazyVim.pick("live_grep", { cwd = LazyVim.root.git() }),
        desc = "Grep",
      },
      {
        "<leader>sG",
        function()
          LazyVim.pick("live_grep", { cwd = root_selectors.package() })()
        end,
        desc = "Grep - Package",
      },
      { "<leader>fc", false },
      { "<leader>fg", false },
    },
  },
}
