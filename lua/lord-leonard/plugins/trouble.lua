return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require "trouble".setup({})

    vim.keymap.set("n", "<leader>tt", function()
      require "trouble".toggle()
    end)

    vim.keymap.set("n", "[t", function()
      require("trouble").next({ skip_groups = true, jump = true });
    end)

    vim.keymap.set("n", "]t", function()
      require("trouble").previous({ skip_groups = true, jump = true });
    end)

    -- diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },

      severity_sort = true,

      signs = {
        enable = true,
        text = {
          ["ERROR"] = signs.Error,
          ["WARN"] = signs.Warn,
          ["HINT"] = signs.Hint,
          ["INFO"] = signs.Info,
        },
        texthl = {
          ["ERROR"] = "DiagnosticDefault",
          ["WARN"] = "DiagnosticDefault",
          ["HINT"] = "DiagnosticDefault",
          ["INFO"] = "DiagnosticDefault",
        },
        numhl = {
          ["ERROR"] = "DiagnosticDefault",
          ["WARN"] = "DiagnosticDefault",
          ["HINT"] = "DiagnosticDefault",
          ["INFO"] = "DiagnosticDefault",
        },
      },

      underline = true,
      update_in_insert = false,

      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },

    })
  end,
}
