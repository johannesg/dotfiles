local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"
-- config.color_scheme = "Nord (Gogh)"
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 12.5
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

config.initial_cols = 120
config.initial_rows = 50

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }

	config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", italic = false })
	config.font_size = 12
	config.line_height = 1.2
	config.cell_width = 1.0

	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe" },
	})

	-- Find installed visual studio version(s) and add their compilation
	-- environment command prompts to the menu
	for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
		local year = vsvers:gsub("Microsoft Visual Studio/", "")
		table.insert(launch_menu, {
			label = "x64 Native Tools VS " .. year,
			args = {
				"cmd.exe",
				"/k",
				"C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
			},
		})
	end
end

config.launch_menu = launch_menu

return config
