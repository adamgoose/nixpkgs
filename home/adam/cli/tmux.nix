{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      nord
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g mouse on
    '';
  };
}
