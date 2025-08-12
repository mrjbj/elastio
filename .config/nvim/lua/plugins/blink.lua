return {
  {
    "Saghen/blink.cmp",
    -- Override LazyVim's default configuration
    opts = function(_, opts)
      -- Merge with LazyVim's existing opts
      return vim.tbl_deep_extend("force", opts, {
        keymap = {
          -- Use a custom mapping set (disable preset to avoid conflicts)
          preset = "none",
          -- Navigation: Tab for next, Shift+Tab for previous
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          -- Selection: Ctrl+Y, Enter, Space to confirm
          ["<CR>"] = { "select_and_accept", "fallback" },
          -- Optional: Ctrl+Space to trigger completion manually
          ["<C-Space>"] = { "show" },
          -- Optional: Ctrl+C to cancel completion
          ["<C-c>"] = { "hide", "fallback" },
          ["<Esc>"] = { "hide", "fallback" },
        },
        -- Ensure LSP sources are enabled
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        -- Optional: Customize appearance (LazyVim already sets borders, but you can tweak)
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          menu = {
            auto_show = true,
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },
        },
      })
    end,
  },
}
