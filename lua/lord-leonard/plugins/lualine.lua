return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    sections = {
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
      },
    },
  },

  config = function()
    require('lualine').setup {
      options = {
        theme = "catppuccin"
        -- ... the rest of your lualine config
      }
    }
  end
}
