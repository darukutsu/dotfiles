local home = vim.fn.getenv("HOME")
local root_dir_path = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", ".idea", ".settings" })
local project_name = vim.fn.fnamemodify(root_dir_path, ":p:h:t")
--local project_name = vim.fn.fnamemodify(root_dir_path, ":p:h")
local workspace_dir = home .. "/.cache/jdtls-workspace/" .. project_name
--local workspace_dir = project_name .. '/.workspace'
--
local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar"),
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/com.microsoft.java.test.plugin*.jar"), "\n")
)

--require("jdtls").start_or_attach({
vim.lsp.config("jdtls", {
  --looks like it's automaticaly solved
  --require('coq').lsp_ensure_capabilities({}),
  cmd = {
    -- Will search in where is Mason bin
    "jdtls",

    -- Not Needed for lspconfig
    --'-jar', vim.fn.glob(home .. '.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),

    "-configuration",
    home .. "/.local/share/nvim/mason/share/jdtls/config/config_ini",

    "-data",
    workspace_dir,
  },

  root_markers = function()
    return root_dir_path
  end,

  --init_options = {
  --  bundles = bundles,
  --  --workspace = workspace_dir,
  --},

  settings = {
    java = {
      --single_file_support = false,
      autobuild = {
        enabled = false,
      },
      --import = {
      --  gradle = {
      --    enabled = true,
      --  },
      --},
      codeGeneration = {
        useBlocks = true,
      },
      completion = {
        chain = {
          enabled = true,
        },
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      edit = {
        smartSemicolonDetection = {
          enabled = false,
        },
        validateAllOpenBuffersOnChanges = {
          enabled = false,
        },
      },
      sources = {
        organizeImports = {
          staticStarThreshold = 999,
          starThreshold = 999,
        },
      },
      symbols = {
        includeSourceMethodDeclarations = true,
      },
      signatureHelp = {
        description = {
          enabled = true,
        },
      },
      saveActions = {
        organizeImports = true,
      },
    },
  },
})
