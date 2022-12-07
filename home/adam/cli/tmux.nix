{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      nord
      prefix-highlight
      vim-tmux-navigator
    ];
    tmuxp.enable = true;
    extraConfig = ''
      set -g mouse on
    '';
  };
}
