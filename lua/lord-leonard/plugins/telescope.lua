return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },

  config = function()
    local builtin = require("telescope.builtin")
    local layout = require('telescope.actions.layout')
    local telescope = require("telescope")

    require("telescope").setup({
      defaults = {
        path_display = { "smart" },

        mappings = {
          i = {
            ["<leader>tp"] = layout.toggle_preview
          },
          n = {
            ["<leader>tp"] = layout.toggle_preview
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = false,                  -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      }
    })

    -- Plugins
    require('telescope').load_extension('fzf')            -- fast soting
    require("telescope").load_extension("live_grep_args") -- live grep with arguments
    require("telescope").load_extension("file_browser")   -- replace netrw

    -- keymaps


    vim.keymap.set("n", '<leader>ff', builtin.fd)
    vim.keymap.set("n", '<C-p>', builtin.git_files, {})

    vim.keymap.set("n", "<C-f>", function()
        builtin.current_buffer_fuzzy_find({ case_mode = "ignore_case" })
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
        path_display = { "smart" },
      });
    end)

    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    vim.keymap.set("n", "<leader>ft",
      function() telescope.extensions.file_browser.file_browser(require('telescope.themes').get_dropdown({})) end, {})

    vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"
  end
}
