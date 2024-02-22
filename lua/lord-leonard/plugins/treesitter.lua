return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    local parsers = require "nvim-treesitter.parsers"

    local parser_config = parsers.get_parser_configs()

    parser_config.aspx = {
      install_info = {
        url = "https://github.com/Lord-Leonard/tree-sitter-aspx", -- local path or git repo
        files = { "src/parser.c" },         -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        generate_requires_npm = false,      -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
      },
      filetype = "aspx",                      -- if filetype does not match the parser name
    }

    configs.setup({
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

      auto_install = true,

      hightlight = {
        enabled = true,
      },

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
    })
  end
}
