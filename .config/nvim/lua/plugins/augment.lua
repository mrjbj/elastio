print("Loading augment.nvim plugin")
return {
  {
    "augmentcode/augment.vim",
    config = function()
      vim.g.augment = {
      -- Default mode to use when creating annotations
      default_mode = "md",

      -- The scheme used to highlight generated text
      highlight_scheme = "CurrentWord",

      -- Enable logging
      logging = false,

      -- The LLMs to use
      lsp = {
        -- When `auto` is true, augment.nvim will try to automatically detect the correct LSP client based on the file type
        auto = true,

        -- For the LSP, we need to define providers for generation, completion, annotation, and editing
        providers = {
          -- Providers for main text generation
          generator = {
            -- Claude is good at generating code
            {
              name = "claude",
              opts = {
                -- You'll need to set up your Claude API key in environment variable
                server_url = "https://api.anthropic.com/v1",
                model = "claude-3-opus-20240229", -- Use the latest model
                api_key = os.getenv("ANTHROPIC_API_KEY"),
                system_message = [[You are an AI programming assistant helping with Elixir development. 
                You provide clear, concise responses focused on functional programming best practices. 
                Emphasize immutability, pattern matching, and pipeline operators. 
                Highlight potential pitfalls like improper error handling. 
                Always consider performance implications and include ExUnit tests when appropriate.
                Provide examples that demonstrate both happy path and error handling. 
                Format code with consistent spacing and two spaces for indentation.
                Provide module and function documentation with @moduledoc and @doc annotations.]],
              },
              filetypes = { "elixir", "ex", "exs", "eex", "heex" },
            },
            -- OpenAI as a fallback
            {
              name = "openai",
              filetypes = { "*" },
              opts = {
                server_url = "https://api.openai.com/v1",
                model = "gpt-4o",
                api_key = os.getenv("OPENAI_API_KEY"),
              },
            },
          },

          -- Providers for completions (usually the same as generators but can be different)
          completer = {
            {
              name = "claude",
              opts = {
                server_url = "https://api.anthropic.com/v1",
                model = "claude-3-opus-20240229",
                api_key = os.getenv("ANTHROPIC_API_KEY"),
              },
              filetypes = { "elixir", "ex", "exs" },
            },
            {
              name = "openai",
              filetypes = { "*" },
              opts = {
                server_url = "https://api.openai.com/v1",
                model = "gpt-4o",
                api_key = os.getenv("OPENAI_API_KEY"),
              },
            },
          },

          -- Annotation providers (for comments and documentation)
          annotator = {
            {
              name = "claude",
              filetypes = { "elixir", "ex", "exs" },
              opts = {
                server_url = "https://api.anthropic.com/v1",
                model = "claude-3-opus-20240229",
                api_key = os.getenv("ANTHROPIC_API_KEY"),
              },
            },
            {
              name = "openai",
              filetypes = { "*" },
              opts = {
                server_url = "https://api.openai.com/v1",
                model = "gpt-4o",
                api_key = os.getenv("OPENAI_API_KEY"),
              },
            },
          },

          -- Providers for editing (refinement, refactoring)
          editor = {
            {
              name = "claude",
              filetypes = { "elixir", "ex", "exs" },
              opts = {
                server_url = "https://api.anthropic.com/v1",
                model = "claude-3-opus-20240229",
                api_key = os.getenv("ANTHROPIC_API_KEY"),
              },
            },
            {
              name = "openai",
              filetypes = { "*" },
              opts = {
                server_url = "https://api.openai.com/v1",
                model = "gpt-4o",
                api_key = os.getenv("OPENAI_API_KEY"),
              },
            },
          },
        },
      },

      -- Keymaps
      -- You can customize these to your preference
      keymaps = {
        -- Main keymaps for accessing augment.nvim features
        ["<leader>a"] = {
          -- Generate code or content
          g = {
            function()
              require("augment").generate()
            end,
            "Generate code",
          },
          -- Get code suggestions/completions
          c = {
            function()
              require("augment").complete()
            end,
            "Complete code",
          },
          -- Create annotations (documentation/comments)
          a = {
            function()
              require("augment").annotate()
            end,
            "Annotate code",
          },
          -- Edit/refactor existing code
          e = {
            function()
              require("augment").edit()
            end,
            "Edit/refactor code",
          },
          -- Open the interactive prompt
          p = {
            function()
              require("augment").prompt()
            end,
            "Prompt",
          },
        },
      },
    }
    end,
  },
}
