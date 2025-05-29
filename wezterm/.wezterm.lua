-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'catppuccin-mocha'
config.color_scheme = 'tokyonight'

config.default_prog = {'bash'}
config.check_for_updates = false

-- and finally, return the configuration to wezterm
return config
