function GoColorYourself() 
  color = "catppuccin"
  vim.cmd.colorscheme(color)

--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  
end

return {
  {
    "folke/tokyonight.nvim",
  },
  { 
    "catppuccin/nvim",
    name = "catppuccin", 
    priority = 1000,

    opts = { 
      transparent_background = true,
      term_colors = true,
      dim_inactive = {
        enabled = true,
      },
      
    },

    config = function() 
      GoColorYourself()
    end
  },
}

