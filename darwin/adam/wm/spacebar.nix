{ pkgs, ... }: {

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      display = "main";
      text_font = ''"FiraCode Nerd Font":Regular:16.0'';
      icon_font = ''"FiraCode Nerd Font":Regular:16.0'';
    };
    # extraConfig = "";
  };

  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

}
