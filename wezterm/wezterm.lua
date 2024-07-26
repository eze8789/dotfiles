local wezterm = require("wezterm")

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

local config = {
	audible_bell = "Disabled",
	font_size = 11.0,
	color_scheme = "Gruvbox Material (Gogh)",

	-- tab bar
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
}

return config
