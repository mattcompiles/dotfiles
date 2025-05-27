return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  "jeffkreeftmeijer/vim-numbertoggle",
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    -- keys = {
    --   {
    --     "<leader>e",
    --     "<cmd>Neotree %:p:h<CR>",
    --     desc = "Open file explorer (current dir)",
    --   },
    -- },
    -- opts = {
    --   close_if_last_window = true,
    --   event_handlers = {
    --     {
    --       event = "file_opened",
    --       handler = function()
    --         require("neo-tree.command").execute({ action = "close" })
    --       end,
    --     },
    --   },
    -- },
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "AndrewRadev/sideways.vim",
    keys = {
      {
        "<leader>Sh",
        "<cmd>SidewaysLeft<CR>",
        desc = "Sideways left",
      },
      {
        "<leader>Sl",
        "<cmd>SidewaysRight<CR>",
        desc = "Sideways right",
      },
      {
        "<leader>Si",
        "<Plug>SidewaysArgumentInsertBefore",
        desc = "Sideways insert argument before",
      },
      {
        "<leader>Sa",
        "<Plug>SidewaysArgumentAppendAfter",
        desc = "Sideways append argument after",
      },
      {
        "<leader>SI",
        "<Plug>SidewaysArgumentInsertFirst",
        desc = "Sideways insert argument first",
      },
      {
        "<leader>SA",
        "<Plug>SidewaysArgumentAppendLast",
        desc = "Sideways append argument last",
      },
      {
        "aa",
        "<Plug>SidewaysArgumentTextobjA",
        mode = { "o", "x" },
      },
      {
        "ia",
        "<Plug>SidewaysArgumentTextobjI",
        mode = { "o", "x" },
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_theme = "ocean"
    end,
  },
  "tpope/vim-surround",
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      {
        "<C-h>",
        "<cmd>TmuxNavigateLeft<CR>",
        desc = "Tmux navigate left",
      },
      {
        "<C-l>",
        "<cmd>TmuxNavigateRight<CR>",
        desc = "Tmux navigate right",
      },
    },
  },
  {
    "swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "navigate left or tab" } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
      { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
    },
    opts = {},
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_max_memory = 18432,
      },
    },
  },
  {
    "kr40/nvim-macros",
    cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
    opts = {
      json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"), -- Location where the macros will be stored
      default_macro_register = "q", -- Use as default register for :MacroYank and :MacroSave and :MacroSelect Raw functions
      json_formatter = "none", -- can be "none" | "jq" | "yq" used to pretty print the json file (jq or yq must be installed!)
    },
  },
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        -- Map mini files synchronize to Ctrl-s
        synchronize = "<C-s>",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    -- Pin version
    version = "1.11.0",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- Pin version
    version = "1.32.0",
  },
}
