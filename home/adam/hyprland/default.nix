{ pkgs, ... }: {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./.eww;
  };

  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font 16";
    terminal = "${pkgs.kitty}/bin/kitty";
  };

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 16;
    theme = "Catppuccin-Macchiato";
  };

  home.file.".config/hypr/hyprland.conf".source = ./.hypr/hyprland.conf;
}
