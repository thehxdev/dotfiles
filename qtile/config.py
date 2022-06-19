# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import libqtile
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import extension
from libqtile.widget import keyboardlayout
import libqtile.widget.keyboardlayout

mod = "mod4"
alt = "mod1"
ctrl = "control"
terminal = guess_terminal()


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
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
	
    Key([mod], "f", lazy.window.toggle_floating()),
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
    # Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "a", lazy.spawn("kitty")), 
    Key([mod], "d", lazy.spawn("pcmanfm")),
    Key([mod], "e", lazy.spawn("/usr/bin/emacsclient -c -a 'emacs'")),

    # Keyboard layout changing
	  Key([ctrl], "space", lazy.widget["keyboardlayout"].next_keyboard()),
	
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "s", lazy.spawn("rofi -show drun")),
    Key([mod, "shift"], "s", lazy.spawn("rofi -show window")),
    Key([mod, "shift"], "f", lazy.spawn("firefox")),
    Key([alt, "shift"], "s", lazy.spawn("poweroff")),
    Key([alt], "j", lazy.spawn("brightnessctl set 10%-")),
    Key([alt], "k", lazy.spawn("brightnessctl set 10%+")),
    Key([], "Print", lazy.spawn("flameshot gui")),
]


groups = [
    Group("web",
          layout="monadtall"),
          
    Group("dev",
          layout="monadtall"),
          
    Group("sys",
          layout="monadtall"),
          
	Group("doc",
          layout="monadtall"),
          
    Group("chat",
          layout="monadtall"),
          
    Group("game",
          layout="monadtall"),
          
    Group("media",
          layout="monadtall"),
          
    Group("gfx",
          layout="monadtall"),
]

for k, group in zip(["1", "2", "3", "4", "5", "6", "7", "8"], groups):
  keys.append(Key([mod], (k), lazy.group[group.name].toscreen()))
  keys.append(Key([mod, "shift"], (k), lazy.window.togroup(group.name)))


layouts = [
	#layout.Tile(border_focus="#a663cc", border_normal="#a4a4a4" , border_width=3, margin=8),
	#layout.Columns(border_focus="#a663cc", border_normal="#a4a4a4" , border_width=3, margin=8),
    layout.MonadTall(border_focus="#a663cc", border_normal="#a4a4a4" , border_width=2, margin=8),
    layout.Max(),
    layout.Floating(border_focus="#a663cc", border_normal="#a4a4a4" , border_width=1),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
	background='#181b20',
	foreground='#e6e6e6',
    font="Mononoki Nerd Font Regular",
    fontsize=13,
    padding=3,
    #icon_size=14,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                
                widget.GroupBox(
					active='#b9cb90',
					inactive='#787878',
					this_current_screen_border='#00d4ff',
					disable_drag=True,
					highlight_method='text',
					font='Ubuntu semiBold',
					padding=1,
					),
                
                widget.Sep(
					foreground="#535965",
					linewidth=1,
					padding=10
					),
				
				widget.CurrentLayout(foreground="#E6926C", font='Ubuntu semiBold'),
				
				widget.Sep(
					foreground="#535965",
					linewidth=1,
					padding=10
					),
				
                widget.Prompt(),
                
                widget.WindowName(font='Ubuntu semiBold' ,max_chars=25),
                
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                #widget.TextBox("default config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.Systray(),
                
                widget.Sep(
					foreground="#535965",
					linewidth=1,
					padding=10
					),
				
                #widget.CPUGraph(core=all, friquency=1, line_width=2),
                widget.CPU(
					foreground='#e55561',
					format=" {load_percent}%",
					update_interval=1.0,
					padding=7),
                
                widget.Memory(
					foreground='#52bbec',
					format=" {MemUsed:.0f} MB",
					update_interval=1.0,
					padding=7),
					
				widget.Net(
					format=" {down}",
					interface='wlan0',
					padding=7),
					
				widget.Battery(
					foreground='#a1ff0a',
					format="{char} {percent:2.0%}",
					charge_char=" ",
					discharge_char=" ",
					empty_char=" ",
					full_char=" ",
					unknown_char=" ",
					low_foreground='#e55561',
					low_percentage=0.15,
					show_short_text=False,
					notify_below=15,
					padding=7
					),
        
                widget.Sep(
					foreground="#535965",
					linewidth=1,
					padding=10
					),
				
                widget.KeyboardLayout(
					display_map={'us': 'us', 'ir': 'ir'},
					configured_keyboards=['us', 'ir'],
					),
                
                widget.Sep(
					foreground="#535965",
					linewidth=1,
					padding=10
					),
				
                widget.Clock(
					foreground='#48b0bd',
					format=" %a %b %d  %I:%M %P"
					),
                
                widget.Sep(
					foreground="#535965",
					linewidth=1,
					padding=10
					),
				
                widget.QuickExit(default_text='[]', countdown_format='[{}]'),
            ],
            28,
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

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
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
