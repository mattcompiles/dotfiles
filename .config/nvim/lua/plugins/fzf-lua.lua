local root_selectors = require("config.root_selectors")

return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        height = 0.99,
        width = 0.99,
        preview = {
          horizontal = "right:50%",
        },
      },
      files = {
        git_icons = false,
        previewer = "bat",
      },
      previewers = {
        bat = {
          args = "--color=always --style=numbers,changes,header-filename,grid",
        },
      },
    },
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
            preview = {
              type = "cmd",
              fn = function(s)
                local package_path = string.gmatch(s[1], "(.+):(.+)")()
                return "bat --color=always " .. package_path
              end,
            },
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
        "<leader>fc",
        function()
          local cmd_string = string.format(
            "rg \z
              'name = \"(.+)\"' \z
              -g \"Cargo.toml\" \z
              -r '$1' \z
              %s \z
              --no-heading \z
              --no-line-number \z
              --trim \z
              --max-count=1",
            LazyVim.root.git()
          )

          require("fzf-lua").fzf_exec(cmd_string, {
            fzf_opts = {
              ["--delimiter"] = ":",
              ["--with-nth"] = 2,
            },
            preview = {
              type = "cmd",
              fn = function(s)
                local crate_path = string.gmatch(s[1], "(.+):(.+)")()
                return "bat --color=always " .. crate_path
              end,
            },
            actions = {
              ["default"] = function(selection, opts)
                local crate_path = string.gmatch(selection[1], "(.+):(.+)")()
                require("fzf-lua.actions").file_switch_or_edit({ crate_path }, opts)
              end,
            },
          })
        end,
        desc = "Find crates",
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
      { "<leader>fg", false },
    },
  },
}
