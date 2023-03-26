import os
import subprocess
from pathlib import Path
from libqtile.lazy import lazy
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.utils import guess_terminal


# a function to find a terminal in PATH and set it
# as default terminal.
# NOTE: This function does not work on NixOS and you MUST
#       set the terminal manually.
def set_terminal():
    # the order matters!
    terminals = [ "alacritty", "kitty", "urxvt", "xterm" ]
    for terminal in terminals:
        term_path = os.path.join("/usr/bin", terminal)
        p = Path(term_path)
        if p.exists():
            return terminal
    else:
        return guess_terminal()


mod = "mod4"

#terminal = "alacritty"
terminal     = set_terminal()
browser      = "firefox"
rofi_drun    = "rofi -show drun"
file_manager = "thunar"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.swap_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.swap_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    #Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    #Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    #Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    #Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # MonadTall Layout Keys
    Key([mod], "i", lazy.layout.grow(), desc="Grow window in monadTall"),
    Key([mod], "m", lazy.layout.shrink(), desc="Shrink window in monadTall"),
    Key([mod, "shift"], "space", lazy.layout.flip(), desc="Flip windows in monadTall"),
    Key([mod], "o", lazy.layout.maximize(), desc="Maximize window size in monadTall"),
    Key([mod], "g", lazy.hide_show_bar("bottom"), desc="hide bottom bar"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Launch apps
    Key([mod], "a", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn(file_manager), desc="Launch file manager"),
    Key([mod], "s", lazy.spawn(rofi_drun), desc="Launch rofi"),
    Key([mod, "shift"], "f", lazy.spawn(browser), desc="Launch internet browser"),
    Key([], "Print", lazy.spawn("flameshot gui")),

    # volume settings with pactl
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%")),

    # volume settings with amixer
    #Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    #Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 1- unmute")),
    #Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 1+ unmute"))
]


groups = [

    Group("",
          layout="monadtall"),

    Group("",
          layout="monadtall"),

    Group("",
          layout="monadtall"),

    Group("",
          layout="monadtall"),

    Group("",
          layout="monadtall"),

    #Group("",
    #      layout="monadtall"),

    #Group("",
    #      layout="monadtall"),

    #Group("",
    #      layout="monadtall"),
]

for k, group in zip(["1", "2", "3", "4", "5"], groups):
    keys.append(Key([mod], (k), lazy.group[group.name].toscreen()))
    keys.append(Key([mod, "shift"], (k), lazy.window.togroup(group.name)))

# Layouts
layouts = [

    layout.MonadTall(
        align = 0,
        new_client_position = "before_current",
        single_border_width = 2,
        border_width  = 2,
        border_focus  = "#AAC4FF",
        border_normal = "#3F4E4F",
        margin = 4,
        ratio = 0.6,
        change_size = 10,
        ),

    layout.Max(),

    #layout.Columns(
    #    border_focus_stack=[
    #        "#d75f5f",
    #        "#8f3d3d"
    #        ],
    #    border_width=4
    #    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    #background = "#3b3b3b",
    background = "#191825",
    foreground = "#e6e6e6",
    font       = "monospace",
    fontsize   = 13,
    padding    = 3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                #widget.GroupBox(),
                widget.GroupBox(
                    active='#576997',
                    inactive='#616161',
                    this_current_screen_border='#9ee6ff',
                    disable_drag=True,
                    highlight_method='text',
                    font='FontAwesome 6 Free',
                    fontsize=18,
                    padding=1,
                    ),

                widget.Sep(
                    foreground="#535965",
                    linewidth=1,
                    padding=10
                ),

                #widget.CurrentLayout(),
                widget.CurrentLayout(
                    foreground="#c8a2ff",
                    #font='Ubuntu semiBold',
                    fontsize = 14
                    ),

                widget.Sep(
                    foreground="#535965",
                    linewidth=1,
                    padding=10
                ),

                #widget.Prompt(),

                widget.WindowCount(
                    fmt = "[{}]"
                    ),

                widget.WindowName(
                    max_chars=40,
                    ),

                #widget.Net(

                #    ),

                #widget.Sep(
                #    foreground="#535965",
                #    linewidth=1,
                #    padding=10
                #),

                widget.Volume(
                    fmt = " {}"
                    ),

                widget.Sep(
                    foreground="#535965",
                    linewidth=1,
                    padding=10
                ),

                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),

                widget.Sep(
                    foreground="#535965",
                    linewidth=1,
                    padding=10
                ),

                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),

                widget.Sep(
                    foreground="#535965",
                    linewidth=1,
                    padding=20
                ),
                #widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
#floating_layout = layout.Floating(
#    float_rules=[
#        # Run the utility of `xprop` to see the wm class and name of an X client.
#        *layout.Floating.default_float_rules,
#        Match(wm_class="confirmreset"),  # gitk
#        Match(wm_class="makebranch"),  # gitk
#        Match(wm_class="maketag"),  # gitk
#        Match(wm_class="ssh-askpass"),  # ssh-askpass
#        Match(title="branchdialog"),  # gitk
#        Match(title="pinentry"),  # GPG key password entry
#    ]
#)

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="galculator"),
        Match(title="Authentication"),
        Match(wm_class="dialog"),
        Match(wm_class="notification"),
        Match(wm_class="error"),
        Match(wm_class="TelegramDesktop"),
        Match(wm_class="Clash for Windows"),
        Match(wm_class="nekoray")
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
