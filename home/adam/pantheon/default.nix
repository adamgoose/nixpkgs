{ pkgs, lib, ...}:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.enable = true;
  dconf.settings = {
    "net/launchpad/plank/docks/dock1" = {
      "icon-size" = 32;
    };
    "org/gnome/desktop/interface" = {
      "clock-format" = "12h";
      "gtk-theme" = "io.elementary.stylesheet.slate";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      "sleep-inactive-ac-timeout" = 0;
      "sleep-inactive-ac-type" = "nothing";
    };
  };
}
