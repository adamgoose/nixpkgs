{pkgs, ...}: let
  k9s = pkgs.fetchFromGitHub {
    owner = "axkirillov";
    repo = "k9s-tokyonight";
    rev = "88db660"; # 2022-12-30
    sha256 = "sha256-W/Pee4jvsMmtcXfPQxTftp0drAGhcj+rhsUOsixvE7Y=";
  };

  btop = pkgs.fetchFromGitHub {
    owner = "aristocratos";
    repo = "btop";
    rev = "a05192f"; # 2025-08-05
    sha256 = "sha256-1xZhQR1BhH2eqax0swlNtnPWIEUTxSOab6sQ3Fv9WQA=";
  };

  bat = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "057ef5d"; # 2025-02-18
    sha256 = "sha256-1xZhQR1BhH2eqax0swlNtnPWIEUTxSOab6sQ3Fv9WQA=";
  };
in {
  # Ghostty
  xdg.configFile."ghostty/config".text = ''
    theme = tokyonight
  '';

  # Wezterm
  programs.wezterm.extraConfig = ''
    color_scheme = "tokyonight",
  '';

  # Helix
  programs.helix = {
    settings = {
      theme = "tokyonight_custom";
    };
    themes = {
      tokyonight_custom = {
        inherits = "tokyonight";
        "ui.background" = {
          fg = "text";
        };
      };
    };
  };

  # k9s
  xdg.configFile."k9s/skins".source = k9s;
  programs.k9s.settings.k9s.ui.skin = "tokyonight";

  # btop
  xdg.configFile."btop/themes".source = "${btop}/themes";
  programs.btop.settings.color_theme = "tokyo-night";

  # bat
  programs.bat = {
    config.theme = "tokyonight";
    themes = {
      tokyonight = {
        src = bat;
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };

  # yazi
  xdg.configFile."yazi/theme.toml".source = "${bat}/extras/sublime/tokyonight_night.tmTheme";

  # zellij
  programs.zellij.settings.theme = "tokyo-night";

  # starship
  programs.starship.settings =
    builtins.fromTOML (builtins.readFile (pkgs.starship + /share/starship/presets/tokyo-night.toml));

  # lazygit
  xdg.configFile."lazygit/config.yml".source = "${bat}/extras/lazygit/tokyonight_moon.yml";
}
