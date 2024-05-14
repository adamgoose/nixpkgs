{unstable, ...}: {
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  services.yabai.config.external_bar = "main:26:0";
  services.sketchybar = {
    enable = true;
    package = unstable.sketchybar;
    config = ''
      #!/usr/bin/env bash

      say bootstrapping
      source "$XDG_CONFIG_HOME/sketchybar/sketchybarrc"
    '';
    extraPackages = with unstable; [
      jq
      ifstat-legacy
      sketchybar-app-font
    ];
  };
}
