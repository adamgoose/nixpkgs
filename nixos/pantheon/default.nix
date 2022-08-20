{ pkgs, ... }: {

  # Enable Pantheon Desktop Environment
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.lightdm = {
      enable = true;
      extraSeatDefaults = "user-session = pantheon";
    };
    desktopManager.pantheon.enable = true;
  };

  # Configuration Management
  programs.pantheon-tweaks.enable = true;
  programs.dconf.enable = true;

  # Theme Packages
  environment.systemPackages = with pkgs; [
    brave # TODO: Move this elsewhere?
    fira-code
    fira-code-symbols
    whitesur-gtk-theme
    whitesur-icon-theme
    gnome.gnome-disk-utility
  ];
}
