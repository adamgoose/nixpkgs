
{ pkgs, ... }:

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
        "vi-mode" "git" "fzf" "direnv"
      ];
    };
  };

  home.shellAliases = {
    reload = "home-manager switch --flake ~/.config/nixpkgs#adam@nixos";
    reload-os = "sudo nixos-rebuild switch --flake /home/adam/.config/nixpkgs#nixos";
  };
}
