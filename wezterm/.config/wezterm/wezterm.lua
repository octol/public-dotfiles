-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration
local config = wezterm.config_builder()

--config.default_prog = { "/usr/bin/zsh", "-l" }
config.initial_cols = 120
config.initial_rows = 40
config.font_size = 11
config.font = wezterm.font("BerkeleyMono Nerd Font Mono", { weight = "Medium" })

config.bold_brightens_ansi_colors = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"

-- config.enable_wayland = false

-- Set the window background color to #282A36
config.colors = {
  foreground = "#D0CFCC",
  background = "#282A36",

  ansi = {
    "#171421",
    "#C01C28",
    "#26A269",
    "#A2734C",
    "#12488B",
    "#A347BA",
    "#2AA1B3",
    "#D0CFCC",
  },

  brights = {
    "#5E5C64",
    "#F66151",
    "#33DA7A",
    "#E9AD0C",
    "#2A7BDE",
    "#C061CB",
    "#33C7DE",
    "#FFFFFF",
  },
}

-- config.harzbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

local function ctrl_pg(dir)
  return wezterm.action_callback(function(window, pane)
    local tab_count = #window:mux_window():tabs()
    if tab_count > 1 then
      window:perform_action(act.ActivateTabRelative(dir), pane)
    else
      window:perform_action(
        act.SendKey({
          key = (dir < 0) and "PageUp" or "PageDown",
          mods = "CTRL",
        }),
        pane
      )
    end
  end)
end

config.keys = {
  { key = "PageUp", mods = "CTRL", action = ctrl_pg(-1) },
  { key = "PageDown", mods = "CTRL", action = ctrl_pg(1) },
}

return config
