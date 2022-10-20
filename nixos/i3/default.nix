{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        rofi
      ];
    };
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "i3";
  };

  # Theme Packages
  environment.systemPackages = with pkgs; [
    brave # TODO: Move this elsewhere?
    hyper
  ];

  fonts.fonts = with pkgs; [
    powerline-fonts
    nerdfonts
  ];
}
