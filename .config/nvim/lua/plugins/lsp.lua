-- this is lsp config and replaces mason for nix based setup
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash" },
        },
        -- CSS LSP (from vscode-langservers-extracted)
        cssls = {
          filetypes = { "css", "scss", "less" },
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore", -- Avoid conflicts with modern CSS
              },
            },
          },
          capabilities = {
            documentFormattingProvider = false, -- Let prettier (via none-ls) handle formatting
          },
        },
        elixirls = {
          cmd = { "elixir-ls" },
          filetypes = { "elixir", "exs", "eex", "heex" },
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              fetchDeps = true,
              enableTestLenses = false,
              suggestSpecs = true,
              mixEnv = "dev",
            },
          },
          capabilities = {
            hoverProvider = true, -- Explicitly enable hover
            completionProvider = {
              resolveProvider = true, -- Ensure documentation in completions
            },
          },
        },
        -- ESLint LSP (from vscode-langservers-extracted)
        eslint = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = true,
              },
            },
          },
        },
        -- HTML LSP (from vscode-langservers-extracted)
        html = {
          filetypes = { "html" },
        },
        -- JSON LSP (from vscode-langservers-extracted)
        jsonls = {
          filetypes = { "json", "jsonc" },
          settings = {
            json = {
              schemas = {
                {
                  fileMatch = { "package.json" },
                  url = "https://json.schemastore.org/package.json",
                },
              },
            },
          },
          capabilities = {
            documentFormattingProvider = false, -- Let prettier (via none-ls) handle formatting
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        -- Nix LSP (using nixd)
        nixd = {
          filetypes = { "nix" },
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> {}", -- Adjust if needed
              },
              options = {
                nixos = {
                  expr = '(builtins.getFlake "${vim.loop.cwd()}").darwinConfigurations.myhost.options',
                },
              },
            },
          },
        },
        -- Python LSP (pyright)
        pyright = {
          filetypes = { "python" },
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        -- SQL LSP
        sqls = {
          filetypes = { "sql", "mysql" },
        },

        -- YAML LSP
        yamlls = {
          filetypes = { "yaml", "yaml.docker-compose", "yaml.kubernetes" },
          settings = {
            yaml = {
              keyOrdering = false,
              schemas = {
                ["https://json.schemastore.org/docker-compose.json"] = "docker-compose.{yml,yaml}",
                ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "k8s.{yml,yaml}",
              },
              completion = true,
            },
          },
          capabilities = {
            documentFormattingProvider = false, -- Let prettier (via none-ls) handle formatting
            completionProvider = {
              resolveProvider = true,
            },
          },
        },
        -- Markdown LSP
        marksman = {
          filetypes = { "markdown", "markdown.mdx" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          single_file_support = true,
          capabilities = {
            completionProvider = true,
            documentLinkProvider = true,
          },
        },
      },
    },
  },
}
