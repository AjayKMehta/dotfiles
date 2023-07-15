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
  "JuliaMono",
  -- <built-in>, BuiltIn
  "Symbols Nerd Font Mono",
})
-- By default, SHIFT-PageUp and SHIFT-PageDown will adjust the viewport
-- scrollback position by one full screen for each press.
config.enable_scroll_bar = true
config.font_size = 12.0
config.initial_rows = 30
config.initial_cols = 100
config.scrollback_lines = 5000
config.use_dead_keys = false
config.window_frame = {
  border_left_width = '0.5cell',
  border_right_width = '0.5cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell',
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 12.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#00ddff',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
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
      args = { 'cmd.exe', '/s', '/k', 'C:/Program Files (x86)/clink/clink_x64.exe', 'inject', '-q' }
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

-- https://wezfurlong.org/wezterm/config/lua/window-events/augment-command-palette.html#adding-a-rename-tab-entry-to-the-palette
local act = wezterm.action
wezterm.on('augment-command-palette', function(window, pane)
  return {
    {
      brief = 'Rename tab',
      icon = 'md_rename_box',

      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
  }
end)

return config
