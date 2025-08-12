-- plugins are configured via lua, not toml.

local function safe_setup(plugin_name, setup_fn)
	local ok, plugin = pcall(require, plugin_name)
	if ok then
		setup_fn(plugin)
	end
end

safe_setup("full-border", function(full_border)
	full_border.setup({
		type = "rounded",
	})
end)

-- You can add more plugins here easily
-- safe_setup("another-plugin", function(plugin)
--     plugin.setup {
--         option = true,
--     }
-- end)
