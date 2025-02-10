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

-- Window initial size
-- config.initial_cols = 210
-- config.initial_rows = 58

config.initial_cols = 280
config.initial_rows = 78

-- Kitty protocol so you can set maps with Cmd key
config.enable_kitty_keyboard = true

-- Window padding
local padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" }
config.window_padding = padding

-- Background blur & transparancy
config.text_background_opacity = 1
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

--
-- Fonts
--
-- https://wezfurlong.org/wezterm/config/lua/wezterm/font.html
-- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html
-- wezterm ls-fonts
-- wezterm ls-fonts --list-system
--
-- config.font = wezterm.font 'JetBrains Mono'
-- config.font = wezterm.font 'Iosevka Term SS06'
-- config.font = wezterm.font({ family = 'Iosevka Term SS06', stretch = 'UltraCondensed'})
-- config.font = wezterm.font({ family = 'Iosevka SS06', stretch = 'UltraCondensed'})
-- config.font_size = 12
-- config.line_height = 1.1
-- config.warn_about_missing_glyphs = true
--
-- local mainFont = "Monaspace Argon"
--
-- -- Monaspace:  https://monaspace.githubnext.com/
-- -- Based upon, contributed to:  https://gist.github.com/ErebusBat/9744f25f3735c1e0491f6ef7f3a9ddc3
-- config.font = wezterm.font({ -- Normal text
-- 	family = mainFont,
-- 	stretch = "SemiCondensed",
-- 	weight = "Regular",
-- 	harfbuzz_features = {
-- 		"calt",
-- 		"liga",
-- 		"dlig",
-- 		"ss01",
-- 		"ss02",
-- 		"ss03",
-- 		"ss04",
-- 		"ss05",
-- 		"ss06",
-- 		"ss07",
-- 		"ss08",
-- 		"ss09",
-- 	},
-- })
--
-- config.font_rules = {
-- 	{ -- Italic
-- 		intensity = "Normal",
-- 		italic = true,
-- 		font = wezterm.font({
-- 			family = mainFont,
-- 			style = "Italic",
-- 		}),
-- 	},
--
-- 	{ -- Bold
-- 		intensity = "Bold",
-- 		italic = false,
-- 		font = wezterm.font({
-- 			-- family = "Monaspace Krypton",
-- 			family = mainFont,
-- 			weight = "DemiBold",
-- 		}),
-- 	},
--
-- 	{ -- Bold Italic
-- 		intensity = "Bold",
-- 		italic = true,
-- 		-- family = "Monaspace Xenon",
-- 		font = wezterm.font({
-- 			family = mainFont,
-- 			style = "Italic",
-- 			weight = "DemiBold",
-- 		}),
-- 	},
-- }

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
	-- { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	-- { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	-- { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	-- { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "h", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
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
