
{ pkgs, name, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      eval "$(oh-my-posh --init --shell zsh --config ~/.omp.json)"
    '';
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      plugins = [
        "vi-mode" "git" "fzf" "direnv" "1password" "nix-shell-init"
      ];
    };

    zplug = {
      enable = true;
      plugins = [{
        name = "lukechilds/zsh-nvm";
      }];
    };
  };

  home.sessionVariables = {
    NODE_VERSIONS = "$HOME/.nvm/versions/node";
    NODE_VERSION_PREFIX = "v";
    EDITOR = "vim";
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.shellAliases = {
    reload = "home-manager switch --flake ~/.config/nixpkgs#${name} && source ~/.zshrc";
  };


  home.file.".omp.json".source = ./files/.omp.json;
  home.file.".oh-my-zsh/custom".source = ./files/oh-my-zsh-custom;
  home.file.".oh-my-zsh/custom".recursive = true;
}
