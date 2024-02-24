return {
  {
    "neovim/nvim-lspconfig",


    dependencies = {
      { "folke/neodev.nvim", opts = {} },

      -- mason
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- cmp
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "FelipeLema/cmp-async-path",
      "hrsh7th/nvim-cmp",
      "ray-x/cmp-treesitter",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- schema Store
      "b0o/schemastore.nvim",
    },

    config = function()
      local cmp = require("cmp")
      local cmp_lsp = require("cmp_nvim_lsp")
      local luasnip = require('luasnip')
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

      print("")

      require("mason").setup({
        PATH = "append"
      })

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
      vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)

      -- Add nvim-lspconfig plugin
      local on_attach = function(_, bufnr)
        local attach_opts = { silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, attach_opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, attach_opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, attach_opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, attach_opts)
        vim.keymap.set('n', '<leader>vsh', vim.lsp.buf.signature_help, attach_opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, attach_opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, attach_opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, attach_opts)
        vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          attach_opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, attach_opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, attach_opts)
        vim.keymap.set('n', 'so', require('telescope.builtin').lsp_references, attach_opts)
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          -- TODO: decide for one of them. Not today
          "omnisharp",
          -- "csharp_ls",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
          "emmet_ls",
          "html",
          -- "custom_elements_ls",
          "jsonls",
          "tsserver", -- js and ts
          "lua_ls",
          "marksman", -- markdown
          "tailwindcss",
          "lemminx"
        },

        handlers = {

          -- extend default handler with capabilities
          function(server_name)
            require("lspconfig")[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,

          --["csharp_ls"] = function()
          --  require "lspconfig".csharp_ls.setup {
          --    capabilities = capabilities,
          --    filetypes = { "cs", "aspx" }
          --  }
          --end,

          ["jsonls"] = function()
            require "lspconfig".jsonls.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                json = {
                  schemas = require "schemastore".json.schemas(),
                  validate = { enable = true }
                }
              }
            }
          end,

          ["omnisharp"] = function()
            require "lspconfig".omnisharp.setup {
              -- cmd = { "omnisharp" },
              on_attach = on_attach,
              capabilities = capabilities,
              -- filetypes = { "cs", "aspx" },
              -- enable_roslyn_analyzers = true,
              -- analyze_open_documents_only = true,
              -- organize_imports_on_format = true,
              -- enable_import_completion = true,
            }
          end,

          ["tsserver"] = function()
            require 'lspconfig'.tsserver.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              cmd = { os.getenv("appdata") .. "\\nvm\\v20.11.0\\typescript-language-server", "--stdio" }
            }
          end,

          ["lua_ls"] = function()
            require 'lspconfig'.lua_ls.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,

          -- needs fixin
          -- ["custom_elements_ls"] = function()
          --   require 'lspconfig'.custom_elements_ls.setup {
          --     on_attach = on_attach,
          --     capabilities = capabilities,
          --   }
          -- end
        },
      })


      luasnip.config.setup {}

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'async_path' },
          { name = 'treesitter' }
        }, {
          { name = "buffer" },
        })
      })


      vim.diagnostic.config({
        severity_sort = true,

        -- TODO: prüfen 
        -- signs = {
        --   text = {
        --     [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
        --     [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
        --     [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
        --     [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
        --   },
        -- },

        underline = true,
        update_in_insert = false,

        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },

        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })


      -- Icons
      local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
      for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end
  }
}
