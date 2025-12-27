#!/run/current-system/sw/bin/bash

# Minimal Power Menu for fuzzel
# Options: Lock, Suspend, Restart, Shutdown
# Requires: fuzzel + Nerd Font (for icons)

# Menu entries with icons
options="󰗼  Logout\n  Suspend\n  Restart\n  Shutdown"

# Show menu and capture selection
chosen=$(echo -e "$options" | fuzzel --dmenu --prompt="Session ❯ " --lines=4)

case "$chosen" in
    "  Suspend")
        systemctl suspend
        ;;
    "  Restart")
        systemctl reboot
        ;;
    "󰗼  Logout")
        if command -v niri >/dev/null 2>&1; then
            niri msg exit
        else
            notify-send "Niri not found!"
        fi
        ;;
    "  Shutdown")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
