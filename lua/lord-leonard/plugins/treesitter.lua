return {
  "nvim-treesitter/nvim-treesitter",

  version = false,

  build = ":TSUpdate",

  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,

  config = function()
    local configs = require("nvim-treesitter.configs")
    local parsers = require "nvim-treesitter.parsers"

    local parser_config = parsers.get_parser_configs()

    parser_config.aspx = {
      install_info = {
        url = "https://github.com/Lord-Leonard/tree-sitter-aspx", -- local path or git repo
        files = { "src/parser.c" },                               -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        generate_requires_npm = false,                            -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false,                   -- if folder contains pre-generated src/parser.c
      },
      filetype = "aspx",                                          -- if filetype does not match the parser name
    }

    configs.setup({
      auto_install = true,

      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "sql",
        "query",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "c_sharp",
        "java",
        "dockerfile"
      },


      highlight = {
        enabled = true,
      },

      ignore_install = {},

      indent = {
        enabled = true
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<bs>",
        },
      },

      sync_install = false,
    })
  end
}
