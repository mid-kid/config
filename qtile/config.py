# -*- coding: utf-8 -*-

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import subprocess
import re


# Custom stuff
class MyCurrentLayout(widget.CurrentLayout):
    def setup_hooks(self):
        def hook_response(layout, group):
            if (group.screen is not None
                    and group.screen == self.bar.screen):
                self.text = "[" + layout.name + "]"
                self.bar.draw()
        hook.subscribe.layout_change(hook_response)

# Main settings
dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating()
auto_fullscreen = True
wmname = "qtile"

# Colors
foreground_color = "E04613"
background_color = "292929"

mod = "mod1"  # Basic modifier
alt = "mod4"  # Alternative, harder to reach modifier

keys = [
    # Select and move windows
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([alt], "k", lazy.layout.shuffle_up()),
    Key([alt], "j", lazy.layout.shuffle_down()),

    # Manage layouts
    Key([mod], "a", lazy.layout.flip()),  # ┬─┬ ¯\_(ツ)
    Key([mod], "Tab", lazy.nextlayout()),

    # Key([mod], "Left", lazy.screen.prevgroup()),
    # Key([mod], "Right", lazy.screen.nextgroup()),

    # Manage processes
    Key([mod], "Return", lazy.spawn("urxvt")),
    Key([mod], "w", lazy.spawncmd()),
    Key([mod], "q", lazy.window.kill()),

    Key([alt], "w", lazy.restart()),
    Key([alt], "q", lazy.shutdown()),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )
    keys.append(
        Key([alt], i.name, lazy.window.togroup(i.name),
            lazy.group[i.name].toscreen())
    )

layouts = [
    layout.Max(name="+"),
    layout.RatioTile(
        name="~",
        border_normal="#" + background_color,
        border_focus="#" + foreground_color
    ),
    layout.MonadTall(
        name="|",
        border_width=1,
        border_normal="#" + background_color,
        border_focus="#" + foreground_color
    )
]

widget_defaults = dict(
    font="DejaVuSansMono",
    fontsize=8,
    padding=3
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method="block",
                    rounded=False,
                    this_current_screen_border=foreground_color
                ),
                widget.Prompt(),
                MyCurrentLayout(),
                widget.WindowName(),
                widget.Systray(),
                widget.Volume(),
                widget.BatteryIcon(),
                widget.ThermalSensor(),
                widget.Clock(format="%Y-%m-%d %I:%M %p")
            ],
            21, background=background_color
        ),
    ),
]


@hook.subscribe.client_new
def dialogs(window):
    if (window.window.get_wm_type() == "dialog"
            or window.window.get_wm_transient_for()):
        window.floating = True


def is_running(process):
    s = subprocess.Popen(["ps", "axuw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
    return False


def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split())


@hook.subscribe.startup
def startup():
    execute_once("nm-applet")
