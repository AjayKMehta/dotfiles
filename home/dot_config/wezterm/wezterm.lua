local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Dracula+"
config.enable_scroll_bar = true
config.default_prog = { "pwsh" }
config.font = wezterm.font_with_fallback({
  'DejaVuSansM Nerd Font Mono',
  -- <built-in>, BuiltIn
  "JetBrains Mono",

  -- <built-in>, BuiltIn
  -- Assumed to have Emoji Presentation
  -- Pixel sizes: [128]
  "Noto Color Emoji",

  -- <built-in>, BuiltIn
  "Symbols Nerd Font Mono",
})
-- By default, SHIFT-PageUp and SHIFT-PageDown will adjust the viewport
-- scrollback position by one full screen for each press.
config.enable_scroll_bar = true
config.scrollback_lines = 3500
config.window_frame = {
  border_left_width = '0.5cell',
  border_right_width = '0.5cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell'
}


local launch_menu = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(
    launch_menu,
    {
      label = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Text = "PowerShell Core" }
      },
      args = { "pwsh.exe", "-NoLogo" }
    }
  )
  table.insert(
    launch_menu,
    {
      label = 'cmd',
      set_environment_variables = {
        prompt = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ',
        DIRCMD = '/d'
      },
      args = { 'cmd.exe' }
    }
  )
  table.insert(
    launch_menu,
    {
      label = "Windows PowerShell",
      args = { "powershell.exe", "-NoLogo" }
    }
  )
end

config.launch_menu = launch_menu
wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if window:is_focused() then
    overrides.color_scheme = 'nordfox'
  else
    overrides.color_scheme = 'nightfox'
  end
  window:set_config_overrides(overrides)
end)

return config
