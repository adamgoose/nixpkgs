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

    # initContent = ''
    #   # disable sort when completing `git checkout`
    #   zstyle ':completion:*:git-checkout:*' sort false
    #   # set descriptions format to enable group support
    #   # NOTE: don't use escape sequences here, fzf-tab will ignore them
    #   zstyle ':completion:*:descriptions' format '[%d]'
    #   # set list-colors to enable filename colorizing
    #   zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    #   # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    #   zstyle ':completion:*' menu no
    #   # preview directory's content with eza when completing cd
    #   zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    #   # switch group using `<` and `>`
    #   zstyle ':fzf-tab:*' switch-group '<' '>'
    # '';
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # programs.fzf.enable = true;
  # programs.fzf.enableZshIntegration = true;
  programs.eza.enable = true;
  programs.eza.enableZshIntegration = true;

  home.file.".oh-my-zsh/custom".recursive = true;
  home.file.".oh-my-zsh/custom".source = ./files/oh-my-zsh-custom;

  # programs.oh-my-posh = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./files/.omp.json));
  # };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      gcloud.disabled = true;
    };
  };
}
