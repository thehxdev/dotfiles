# i3 WM Config

This i3 WM config file is minimal without crazy changes.

## Dependencies

If you can modify the config and `autostart` section it's OK to make your changes and
prevent errors. But if thats not the case, install these packages before running **i3**.

- `nitrogen`
- `picom`
- `nm-applet` (Network Manager Applet)
- `nitrogen`
- `rofi`
- `alacritty`
- `Thunar` (File Manager)

## Xresources file

This file used to correct bad font rendering in i3.
Copy and paste it in your `$HOME` directory and rename it to `.Xresources`.


## Key Bindings

`Mod` = `Win Key`

- `Mod + s` -> `rofi -show drun`
- `Mod + a` -> `alacritty`
- `Mod + d` -> `thunar`
- `Mod + h` -> focuse left
- `Mod + l` -> focuse right
- `Mod + w` -> tabbed layout
- `Mod + e` -> toggle split layout
- `Mod + Shift + f` -> `firefox`

