local jdtls = require('jdtls')
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)


local root_markers = { "build.xml", ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir_test = require("jdtls.setup").find_root(root_markers)
if root_dir_test == "" then
  return
end

local java_path = vim.fs.normalize("C:/Program Files/Amazon Corretto/jdk21.0.2_13/bin/java")
local jdtls_path = vim.fs.normalize(vim.fn.glob("$MASON") .. "/packages/jdtls")
local launcher_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar"
local project_name = vim.fn.fnamemodify(root_dir_test, ":p:h:t")
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
local config_dir = vim.fs.normalize(jdtls_path .. "/config_win")
local lombok_path = vim.fs.normalize(jdtls_path .. "/lombok.jar")
print("lombok path: " .. lombok_path)


print("root dir: " .. root_dir_test)
print("Project name: " .. project_name)

os.execute("mkdir " .. workspace_dir)

local config = {
  capabilities = capabilities,
  on_attach = On_lsp_attach,

  cmd = {
    -- 💀
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',

    -- 💀
    '-javaagent:' .. lombok_path,

    '-Xmx6g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', launcher_jar,

    -- 💀
    '-configuration', config_dir,

    -- 💀
    '-data', workspace_dir
  },

  root_dir = root_dir_test,

  -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      autobuild = {
        enabled = false
      },

      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "C:/Program Files/Amazon Corretto/jdk1.8.0_332",
          },
        }
      },

      eclipse = {
        downloadSources = true,
      },

      home = "C:/Program Files/Amazon Corretto/jdk1.8.0_332",

      jdt = {
        ls = {
          lombokSupport = {
            enabled = true
          }
        }
      },

      implementationsCodeLens = {
        enabled = true
      },

      referenceCodeLens = {
        enabled = true
      },

      references = {
        includeDecompiledSources = true,
      },

      inlayhints = {
        parameterNames = {
          enabled = true
        }
      },

      project = {
        encoding = "windows-1252",
      }
    }
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#extended-client-capabilities
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },

  handlers = {},
}

config.handlers['language/status'] = function() end
jdtls.start_or_attach(config)
