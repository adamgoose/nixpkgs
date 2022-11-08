
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

  home.file.".task/hooks".source = "${pkgs.trackwarrior}/taskwarrior/hooks";
  home.file.".task/hooks".recursive = true;
  home.file.".timewarrior/extensions".source = "${pkgs.trackwarrior}/timewarrior/extensions";
  home.file.".timewarrior/extensions".recursive = true;

}
