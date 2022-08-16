
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
      plugins = [
        "vi-mode" "git" "fzf" "direnv" "1password"
      ];
    };

    zplug = {
      enable = true;
      plugins = [{
        name = "lukechilds/zsh-nvm";
      }];
    };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.shellAliases = {
    reload = "home-manager switch --flake ~/.config/nixpkgs#${name}";
  };


  home.file.".omp.json".source = ./files/.omp.json;
}
