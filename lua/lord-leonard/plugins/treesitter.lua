return {
  "nvim-treesitter/nvim-treesitter",

  version = false,

  build = ":TSUpdate",

  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,

  config = function()
    local configs = require("nvim-treesitter.configs")

    require 'nvim-treesitter.install'.prefer_git = false

    configs.setup({
      ensure_installed = {
        "c",
        "c_sharp",
        "css",
        "dockerfile",
        "html",
        "lua",
        "java",
        "javascript",
        "typescript",
        "query",
        "scss",
        "sql",
        "vim",
        "vimdoc",
      },

      sync_install = false,

      highlight = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<bs>",
        }
      },

      indent = { enable = true },
    })
  end
}
