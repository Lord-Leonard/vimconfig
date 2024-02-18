return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    local parsers = require "nvim-treesitter.parsers"

    local parser_config = parsers.get_parser_configs()

    parser_config.html.filetype_to_parsename = "aspx"

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
