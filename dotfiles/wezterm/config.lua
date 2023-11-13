local config = {}

config.color_scheme = "nightfox"

config.font = wezterm.font({
	family = "Monaspace Neon",
	harfbuzz_features = {
		"calt=1",
		"clig=1",
		"ss01",
		"ss02",
		"ss03",
		"ss04",
		"ss05",
		"ss06",
		"ss07",
		"ss08",
	},
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
