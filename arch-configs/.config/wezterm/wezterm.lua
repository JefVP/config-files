-- pull in wezterm API
local wezterm = require 'wezterm'

-- table holding configs
local config = {
	enable_tab_bar = false,
	enable_scroll_bar = false,
	adjust_window_size_when_changing_font_size = false,
	font_size = 11.4
}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- applying config choices
-- example
-- config.color_scheme = 'AdventureTime'
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.color_scheme = 'Atelier Heath (base16)'
config.adjust_window_size_when_changing_font_size = false
config.font_size = 11.4

-- return config to wezterm
return config
