{ pkgs, name, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      plugins = [
        "direnv"
        "fzf"
        "git"
        "vi-mode"
      ]
      ++ lib.lists.optional (pkgs.stdenv.isDarwin) "macos"
      ;
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
      catppuccin = builtins.readFile (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "bat"; # Bat uses sublime syntax for its themes
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        } + "/Catppuccin-macchiato.tmTheme");
    };
  };

  home.shellAliases = {
    cat = "bat";
    reload = "home-manager switch --flake ~/.config/nixpkgs#${name} && source ~/.zshrc";
  };
}

