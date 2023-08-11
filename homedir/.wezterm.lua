local wezterm = require 'wezterm'
local config = {}

config.keys = {
  {
    key = '[',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte

config.font = wezterm.font 'JetBrains Mono'
config.audible_bell = "Disabled"
return config
