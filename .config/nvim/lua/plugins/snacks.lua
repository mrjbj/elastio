return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        buffers = { focus = "list" },
        explorer = { focus = "list" },
        projects = { focus = "list" },
        recent = { focus = "list" },
        git_branches = { focus = "list" },
        git_log = { focus = "list" },
        search_history = { focus = "list" },
        command_history = { focus = "list" },
        loclist = { focus = "list" },
        marks = { focus = "list" },
        notifications = {
          focus = "list",
          win = {
            layout = "bottom",
            preview = {
              height = 0.4, -- 40% of height
            },
          },
        },
      },
    },
    zoom = {
      enabled = true,
      keys = {
        ["<leader>z"] = {
          function()
            local ok, snacks = pcall(require, "snacks")
            if ok then
              snacks.zen.zoom()
            else
              -- fallback if snacks is not available
              if vim.g.zoomed then
                vim.cmd("wincmd _ | wincmd |")
                vim.g.zoomed = false
              else
                vim.cmd("wincmd | wincmd _")
                vim.g.zoomed = true
              end
            end
          end,
          desc = "Toggle zoom",
        },
      },
    },

    terminal = {
      bo = {
        filetype = "snacks_terminal",
      },
      wo = {},
      keys = {
        q = "hide",
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
          if f == "" then
            Snacks.notify.warn("No file under cursor")
          else
            self:hide()
            vim.schedule(function()
              vim.cmd("e " .. f)
            end)
          end
        end,
        term_normal = {
          "<esc>",
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd("stopinsert")
            else
              self.esc_timer:start(200, 0, function() end)
              return "<esc>"
            end
          end,
          mode = "t",
          expr = true,
          desc = "Double escape to normal mode",
        },
      },
    },
  },
}
