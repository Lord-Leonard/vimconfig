return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },

  config = function()
    require("telescope").setup({
      defaults = {
        path_display = { "smart" }
      }
    })

    -- Plugins
    require('telescope').load_extension('fzf')            -- fast soting
    require("telescope").load_extension("live_grep_args") -- live grep with arguments

    -- keymaps
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", '<leader>ff', builtin.fd, {})
    vim.keymap.set("n", '<C-p>', builtin.git_files, {})
    vim.keymap.set(
      "n",
      "<C-f>",
      function()
        builtin.current_buffer_fuzzy_find({case_mode="ignore_case"})
      end,
      { noremap = true }
    )

    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand('<cword>')
      builtin.grep_string({ search = word })
    end)

    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand('<cWORD>')
      builtin.grep_string({ search = word })
    end)

    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({
        search = vim.fn.input("Grep > "),
        only_sort_text = true,
        max_results = 20,
        disable_coordinates = true,
      });
    end)

    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end
}
