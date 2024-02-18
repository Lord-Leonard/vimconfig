return {
  "neovim/nvim-lspconfig",


  dependencies = {
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
            capabilities = capabilities,
            cmd = { os.getenv("appdata") .. "\\nvm\\v20.11.0\\typescript-language-server", "--stdio" }
          }
        end,

        ["lua_ls"] = function()
          require 'lspconfig'.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end
      },
    })


    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
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


    -- vim.diagnostic.config({
    --   float = {
    --     focusable = false,
    --     style = "minimal",
    --     border = "rounded",
    --     source = "always",
    --     header = "",
    --     prefix = "",
    --   },
    -- })
  end
}
