return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

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

      sync_install = false,
      auto_install = true,

      hightlight = {
        enabled = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enabled = true
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end
}
