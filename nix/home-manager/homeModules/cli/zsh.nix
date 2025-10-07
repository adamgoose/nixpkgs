{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;

    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      ZSH_DISABLE_COMPFIX=true
    '';

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      plugins =
        [
          "gcd"
          "direnv"
          "vi-mode"
        ]
        ++ lib.lists.optional (pkgs.stdenv.isDarwin) "macos";
    };

    zplug.enable = true;
  };

  programs.fzf.enableZshIntegration = true;
  programs.eza.enableZshIntegration = true;
  programs.yazi.enableZshIntegration = true;
  programs.atuin.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;

  home.file.".oh-my-zsh/custom".recursive = true;
  home.file.".oh-my-zsh/custom".source = ./files/oh-my-zsh-custom;
}
