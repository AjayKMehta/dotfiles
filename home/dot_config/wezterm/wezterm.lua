local launch_menu = {}
local wezterm = require 'wezterm';
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(
    launch_menu,
    {
      label = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Text = "PowerShell Core" }
      },
      args = { "pwsh.exe", "-NoLogo", "-NoExit" }
    }
  )

  local set_environment_variables = {}
  set_environment_variables['prompt'] =
  '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m '
  -- use a more ls-like output format for dir
  set_environment_variables['DIRCMD'] = '/d'

  table.insert(
    launch_menu,
    {
      label = 'cmd',
      set_environment_variables = set_environment_variables,
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

wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if window:is_focused() then
    overrides.color_scheme = 'nordfox'
  else
    overrides.color_scheme = 'nightfox'
  end
  window:set_config_overrides(overrides)
end)

return {
  color_scheme = "Dracula+",
  default_prog = { "pwsh" },
  font = wezterm.font {
    family = 'JetBrains Mono',
    stretch = 'Expanded',
    weight = 'Regular',
    assume_emoji_presentation = true
  },
  launch_menu = launch_menu,
  -- By default, SHIFT-PageUp and SHIFT-PageDown will adjust the viewport
  -- scrollback position by one full screen for each press.
  enable_scroll_bar = true,
  scrollback_lines = 3500,
  window_frame = {
    border_left_width = '0.5cell',
    border_right_width = '0.5cell',
    border_bottom_height = '0.25cell',
    border_top_height = '0.25cell'
  }
}
