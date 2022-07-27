
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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.shellAliases = {
    reload = "home-manager switch --flake ~/.config/nixpkgs#adam@nixos";
    reload-os = "sudo nixos-rebuild switch --flake /home/adam/.config/nixpkgs#nixos";
  };

  home.sessionVariables = {
    AWS_VAULT_BACKEND = "pass";
    AWS_VAULT_PASS_PASSWORD_STORE_DIR = "/Users/adam/.local/share/password-store";
    PASSWORD_STORE_DIR = "/Users/adam/.local/share/password-store";
  };

  home.file.".omp.json".source = ./files/.omp.json;
}
