{ pkgs
, username
, ...
}: rec {
  imports = [
    ./git.nix
    ./ssh.nix
    ./zellij.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    jq
    enc
    gum
    btop
    htop
    wget
    xplr
    yazi
    doggo
    unzip
    watch
    cachix
    httpie
    rclone
    hostctl
    neofetch
  ];

  xdg.enable = true;

  home.file.".config/btop/btop.conf".text = ''
    color_theme = "/home/${username}/.config/btop/themes/catppuccin_macchiato.theme";
    vim_keys = True
  '';
  home.file.".config/btop/themes".recursive = true;
  home.file.".config/btop/themes".source =
    pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "btop";
        rev = "89ff712eb62747491a76a7902c475007244ff202";
        sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
      }
    + "/themes";

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR --mouse";
      theme = "catppuccin";
    };
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat"; # Bat uses sublime syntax for its themes
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-macchiato.tmTheme";
      };
    };
  };

  home.shellAliases = {
    cat = "bat";
    nixpkgs = "cd ~/src/github.com/adamgoose/nixpkgs";
  };
}
