{ pkgs, unstable, ... }: {

  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  services.sketchybar = {
    enable = true;
    package = unstable.sketchybar;
    config = ''
      #!/usr/bin/env bash

      say bootstrapping
      source "/Users/adam/.config/sketchybar/sketchybarrc"
    '';
    extraPackages = with unstable; [
      jq
      ifstat-legacy
      sketchybar-app-font
    ];
  };

}
