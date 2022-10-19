local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'

return {
	-- The default applications that we will use in keybindings and widgets
	default = {
		-- Default terminal emulator
		terminal = 'env alacritty',
		-- Default web browser
		web_browser = 'env firefox',
        -- Private web browser
        private_web_browser = ' env firefox -private-window',
		-- Default text editor
		text_editor = 'leafpad',
		-- Default file manager
		file_manager = 'thunar',
		-- Default media player
		multimedia = 'mpv',
		-- Default game, can be a launcher like steam
		game = 'env steam',
		-- Default graphics editor
		graphics = 'gimp',
		-- Default sandbox
		sandbox = 'virt-manager',
		-- Default IDE
		development = 'code',
		-- Default network manager
		network_manager = 'nm-connection-editor',
		-- Default bluetooth manager
        bluetooth_manager = 'blueberry',
		-- Default power manager (leaving this here as example)
		power_manager = 'xfce4-power-manager',
		-- Default GUI package manager
		package_manager = 'pamac-manager',
		-- Default locker
		lock = 'i3lock-fancy',
		-- Default quake terminal
		quake = 'env alacritty --title QuakeTerminal',

		-- Default rofi global menu (This is not used in material-awesome as it sometimes froze rofi completely)
		-- kept in the config in-case anyone wants to take a crack at supporting it
		rofi_global = 'env rofi -dpi ' .. screen.primary.dpi ..
							' -show "Global Search" -modi "Global Search":' .. config_dir ..
							'/configuration/rofi/global/rofi-spotlight.sh' ..
							' -theme ' .. config_dir ..
							'/configuration/rofi/global/rofi.rasi',

		-- Default app menu
		rofi_appmenu = 'env rofi -dpi ' .. screen.primary.dpi ..
							' -show drun -theme ' .. config_dir ..
							'/configuration/rofi/appmenu/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"',

		-- You can add more default applications here
	},

	-- List of apps to start once on start-up
	run_on_start_up = {
		-- Compositor
		'picom -b --experimental-backends --dbus --config ' .. config_dir .. '/configuration/picom.conf',
		-- network applet for network connections
		'nm-applet --indicator > /dev/null',
        -- Automount
        'udiskie -s > /dev/null',
        -- Hide mouse cursor when idle
        'unclutter --timeout 2 --exclude-root --ignore-scrolling -b',
        -- Variety Wallpater Manager
        'variety',
		-- Blueman applet
		'blueberry-tray > /dev/null',
		-- ibus keyboard daemon for keyboard management and emoji typing
		'ibus-daemon --xim --daemonize',
		-- scream audio sink for windows10 VM audio
    	'scream-start',
		-- turn on numlock
    	'numlockx on',
        -- volume
        'pa-applet',
        -- power manager
        'xfce-power-manager',
        -- syncthing
        'syncthing-gtk -m',
        -- redshif
        'redshift-gtk',
        -- pamac
        'pamac-tray',
        --clipit
        'clipit',
        -- dropbox
        'dropbox',
		-- start kdeconnect-indicator (script to handle awesome restarts)
		utils_dir .. 'kdeconnect',
		-- Polkit and keyring (uncomment the one you use)
         '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & ' ..
         'eval $(gnome-keyring-daemon --s --components=pkcs11,secrets,ssh,gpg)',
         -- 'eval $(ssh-agent -s) &'
		-- Load X colors
		'xrdb $HOME/.Xresources',
		-- Lockscreen timer
		[[
		xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
		"i3lock-fancy" ""
		]],
		-- Set brightness to 50% on LVDS output because my laptop battery is bad
		utils_dir .. 'laptop-brightness set 50',
		-- Load users custom xmodmap if they have one
		'xmodmap $HOME/.Xmodmap',

		-- Spawn "dirty" apps that can linger between sessions
		-- It is suggested you copy the contents of awspawn into ~/.config/awesomestart
		-- then remove the "$HOME/.config/awesomestart" line from the APPS array
		'~/.config/awesome/configuration/awspawn > /dev/null'

		-- You can add more start-up applications here
	},

	-- List of binaries/shell scripts that will execute for a certain task
	utils = {
		-- Hikari's screenshot utilities (requires ksnip to be installed)
		screenshot = utils_dir .. 'screenshot -m -s',
		region_screenshot = utils_dir .. 'screenshot -r -s',
		delayed_screenshot = utils_dir .. 'screenshot -d 5 -c -r -s',
		ss_and_edit_screenshot = utils_dir .. 'screenshot -r',

		-- Other screenshot utilities using maim
		-- Fullscreen screenshot
		full_screenshot = utils_dir .. 'snap full',
		-- Area screenshot
		area_screenshot = utils_dir .. 'snap area',

		-- Emoji keyboard toggle script
		-- (edit the script inside ~/.config/awesome/utilities to use your keyboard layout settings!)
		-- Requires: ibus and uniemoji to be installed
		emoji_toggle = utils_dir .. 'emoji-toggle',

		-- Update profile picture
		update_profile  = utils_dir .. 'profile-image'
	}
}
