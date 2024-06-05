local wezterm = require("wezterm")
local config = {}

local my_neutron = wezterm.color.get_builtin_schemes()["Neutron"]
my_neutron.ansi[1] = "#6c6c6c"
my_neutron.brights[1] = "#6c6c6c"

config.color_schemes = {
	["My Neutron"] = my_neutron,
}

config.color_scheme = "My Neutron"

config.font = wezterm.font("Fira Code", {
	italic = false,
	stretch = "Normal",
	style = "Normal",
	weight = "Regular",
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

	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
}

config.scrollback_lines = 20000

return config
