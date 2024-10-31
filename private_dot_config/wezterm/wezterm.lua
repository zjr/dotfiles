-- Pull in wezterm API
local wezterm = require("wezterm")

-- This holds the configuration
local config = wezterm.config_builder()

-- Start with fish
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

-- Window config
config.tab_max_width = 40
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- Background blur & transparancy
config.text_background_opacity = 1
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

-- Font config
config.font = wezterm.font_with_fallback({
	{ family = "Iosevka Term Curly", stretch = "Expanded" },
	{ family = "Symbols Nerd Font Mono", scale = 0.9 },
})

config.font_size = 13
config.use_cap_height_to_scale_fallback_fonts = true

-- Color scheme (switches for light/dark mode)
local function scheme_for_appearance(appearance)
	if appearance:find("Light") then
		return "Catppuccin Latte"
	else
		return "Catppuccin Frappe"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Key bindings
config.keys = {
	{ key = "Enter", mods = "CMD", action = wezterm.action.ToggleFullScreen },
	{ key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
}

-- NeoVim ZenMode Integration
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
