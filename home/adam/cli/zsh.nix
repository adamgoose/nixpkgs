{ pkgs, name, lib, ... }:

{
  programs.zsh = {
    enable = true;
    # enableAutosuggestions = true;
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
      plugins = [
        {
          name = "marlonrichert/zsh-autocomplete";
        }
      ];
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR --mouse";
      theme = "Nord";
    };
    themes = {
      Nord = builtins.readFile (pkgs.fetchFromGitHub
        {
          owner = "arcticicestudio";
          repo = "nord-sublime-text"; # Bat uses sublime syntax for its themes
          rev = "57cb731ef47b9ede6b8af23cdfcec735fe545c6a";
          sha256 = "sha256-1VXmh7xP/gs9MISaTISfIx9O83jxncU2yRml3Cb3I/0=";
        } + "/Nord.sublime-color-scheme");
    };
  };

  home.shellAliases = {
    cat = "bat";
    reload = "home-manager switch --flake ~/.config/nixpkgs#${name} && source ~/.zshrc";
  };
}

