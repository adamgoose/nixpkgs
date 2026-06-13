{pkgs, ...}: {
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    montserrat
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware = {
    graphics.enable = true;
  };
}
