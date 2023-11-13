local config = {}

config.color_scheme = "Tokyo Night"

config.font = wezterm.font({
	family = "Fira Code",
})

config.font_size = 13.0

config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.5,
}

config.keys = {
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal,
	},

	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical,
	},

	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Prev"),
	},

	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Next"),
	},
}

return config
