{flavor ? ""}: {
  pkgs,
  lib,
  ...
}: let
  dashFlavor =
    if flavor != ""
    then "-" + flavor
    else "";
  underscoreFlavor =
    if flavor != ""
    then "_" + flavor
    else "";

  k9s = pkgs.fetchFromGitHub {
    owner = "sasoria";
    repo = "k9s-theme";
    rev = "22cfbb2"; # 2024-12-27
    sha256 = "sha256-n9fXr2M+ygrJhTAQnCWhtByf4MBGvR1LPuF5JDmFkbM=";
  };
  btop = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "btop";
    rev = "6d6abdc"; # 2023-07-18
    sha256 = "sha256-sShQYfsyR5mq/e+pjeIsFzVZv3tCpQEdGC9bnTKlQ5c=";
  };
  zellij = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "zellij";
    rev = "3122621"; # 2025-07-14
    sha256 = "sha256-vmFilwX+ojYk3Q9FtRm98PUSfqVCUcv0GAkCFi3PBUU=";
  };
  starship = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "starship";
    rev = "c6aeb28"; # 2025-04-10
    sha256 = "sha256-oFHyel6nYOPdK9VbNp7KbKL/3WeBp/SFHzKTq/9Bhh8=";
  };
in {
  # Ghostty
  xdg.configFile."ghostty/config".text = ''
    theme = "Rose Pine ${lib.toUpper (builtins.substring 0 1 flavor)}${builtins.substring 1 999 flavor}"
  '';

  # Wezterm
  programs.wezterm.extraConfig = ''
    color_scheme = "rose-pine${dashFlavor}",
  '';

  # Helix
  programs.helix = {
    settings = {
      theme = "rose_pine_custom";
    };
    themes = {
      rose_pine_custom = {
        inherits = "rose_pine${underscoreFlavor}";
        "ui.background" = {
          fg = "text";
        };
      };
    };
  };

  # k9s
  xdg.configFile."k9s/skins".source = k9s;
  programs.k9s.settings.k9s.ui.skin = "rose-pine${dashFlavor}";

  # btop
  xdg.configFile."btop/themes".source = btop;
  programs.btop.settings.color_theme = "rose-pine${dashFlavor}";

  # bat (missing)
  # yazi (missing)

  # zellij
  xdg.configFile."zellij/themes".source = "${zellij}/dist";
  programs.zellij.settings.theme = "rose-pine${dashFlavor}";

  # starship
  programs.starship.settings =
    {
      palette = "rose-pine${dashFlavor}";
    }
    // builtins.fromTOML (builtins.readFile (starship + /rose-pine${dashFlavor}.toml));

  # process-compose
}
