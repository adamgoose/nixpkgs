{ unstable, ... }: {

  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
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
