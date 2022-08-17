{ pkgs, lib, ...}:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/power" = {
      "sleep-inactive-ac-timeout" = "0";
      "sleep-inactive-ac-type" = "never";
    };
  };
}
