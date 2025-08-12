return {
  -- Configure conform.nvim for formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
        python = { "black", "isort" },
        css = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
        elixir = { "mix_format" },
        exs = { "mix_format" },
        eex = { "mix_format" },
        heex = { "mix_format" },
        markdown = { "markdownlint" },
        sh = { "shfmt" },
        mysql = { "pg_format" },
        plsql = { "pg_format" },
        sql = { "pg_format" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        lua = { "stylua" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "120" },
        },
        mix_format = {
          command = "mix",
          args = { "format", "--check-equivalent", "$FILENAME" },
          stdin = false,
          cwd = function(_, ctx)
            local root = vim.fs.find({ "mix.exs" }, { upward = true, path = ctx.dirname })[1]
            return root and vim.fs.dirname(root) or nil
          end,
          requires_cwd = true,
          exit_codes = { 0, 1 },
          reload = true,
        },
        pg_format = {
          command = "pg_format",
          args = { "--spaces", "2", "--keyword-case", "2", "--comma-start", "-" },
        },
      },
    },
  },
  -- Configure nvim-lint for linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
        python = { "ruff" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
      },
      linters = {
        markdownlint = {
          args = { "--disable", "MD013" },
        },
      },
    },
  },
}
