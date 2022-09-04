local launch_menu = {}
local wezterm = require 'wezterm';

launch_menu = {
  {
    args = { "ctop" },
  },
  {
    label = "Git Bash",
    args = { "git-bash.exe", "--cd-to-home" },
  },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(launch_menu, {
    label = "PowerShell",
    args = { "powershell.exe", "-NoLogo" }
  }
  )

  table.insert(launch_menu, {
    label = wezterm.format {
      { Attribute = { Intensity = "Bold" } },
      { Text = "pwsh" }
    },
    args = { "pwsh.exe", "-NoLogo" }
  }
  )

end

return {
  color_scheme = "Aurora",
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
    border_top_height = '0.25cell',
    border_left_color = '#FAEE00',
    border_right_color = '#FAEE00',
    border_bottom_color = '#FAEE00',
    border_top_color = '#FAEE00',
  }
}
