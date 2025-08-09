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
  };

  programs.fzf.enableZshIntegration = true;
  programs.eza.enableZshIntegration = true;
  programs.yazi.enableZshIntegration = true;
  programs.atuin.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;

  home.file.".oh-my-zsh/custom".recursive = true;
  home.file.".oh-my-zsh/custom".source = ./files/oh-my-zsh-custom;
}
