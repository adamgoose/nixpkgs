{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      plugins =
        [
          "fzf"
          "gcd"
          "direnv"
          "vi-mode"
        ]
        ++ lib.lists.optional (pkgs.stdenv.isDarwin) "macos";
    };

    zplug = {
      enable = true;
      plugins = [];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

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
    restart-nix = "sudo launchctl stop org.nixos.nix-daemon && sudo launchctl start org.nixos.nix-daemon";
    nixpkgs = "cd ~/src/github.com/adamgoose/nixpkgs";
  };

  home.file.".oh-my-zsh/custom".recursive = true;
  home.file.".oh-my-zsh/custom".source = ./files/oh-my-zsh-custom;
}
