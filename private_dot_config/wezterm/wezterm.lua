-- Pull in wezterm API
local wezterm = require("wezterm")

-- This holds the configuration
local config = wezterm.config_builder()

-- Start with fish
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

-- Window config
config.tab_max_width = 80
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false
config.use_resize_increments = false

-- Window padding
local padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" }
config.window_padding = padding

-- Background blur & transparancy
config.text_background_opacity = 1
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

-- Font config
config.font_size = 13

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

-- NeoVim unpadding
wezterm.on("user-var-changed", function(window, _, name, value)
	if name == "NVIM_ENTER" then
		local overrides = window:get_config_overrides() or {}
		if value == "1" then
			overrides.window_padding = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0,
			}
		else
			overrides.window_padding = padding
		end
		window:set_config_overrides(overrides)
	end
end)

return config
