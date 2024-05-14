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
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "FiraMono" "JetBrainsMono" "Iosevka"];})
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
    package = unstable._1password;
  };

  programs._1password-gui = {
    enable = true;
    package = unstable._1password-gui;
  };

  hardware = {
    opengl.enable = true;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };
}
