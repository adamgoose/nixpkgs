{ pkgs, unstable, ... }:
let
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
in
{
  environment.systemPackages = with pkgs; [
    kitty
    # brave
    tmux
    socat
    brightnessctl
    # sddm-catppuccin
  ] ++ (with unstable; [
    brave
  ]);

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
    montserrat
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm = {
  #   enable = true;
  #   theme = "catppuccin-macchiato";
  # };

  hardware = {
    opengl.enable = true;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

}
