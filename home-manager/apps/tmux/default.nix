{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [
      nord
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g mouse on
    '';
  };
}
