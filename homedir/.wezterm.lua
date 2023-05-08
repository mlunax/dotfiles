local wezterm = require 'wezterm'
local config = {}

config.keys = {
  {
    key = '[',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

config.font = wezterm.font 'JetBrains Mono'
return config
