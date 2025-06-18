{
  pkgs,
  unstable,
  ...
}: let
  inherit (pkgs) stdenv fetchFromGitHub;

  sddm-catppuccin = stdenv.mkDerivation rec {
    pname = "sddm-catppuccin";
    version = "";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "sddm";
      rev = "bde6932";
      sha256 = "sha256-ceaK/I5lhFz6c+UafQyQVJIzzPxjmsscBgj8130D4dE=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes/
      cp -r src/* $out/share/sddm/themes/
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    tmux
    socat
    tigervnc
    brightnessctl
    adwaita-icon-theme
  ];

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

  programs.steam = {
    enable = true;
  };

  programs._1password = {
    enable = true;
    package = unstable._1password-cli;
  };

  programs._1password-gui = {
    enable = true;
    package = unstable._1password-gui;
  };

  hardware = {
    graphics.enable = true;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  # services.gvfs.enable = true;
}
