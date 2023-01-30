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

  programs.zsh.initExtra = ''
    function ide() {
      APP=$1 tmuxp load -a ~/.config/tmuxp/tmuxp-ide.yaml
      tmux select-window -t $1
    }
  '';

  home.file.".config/tmuxp/tmuxp-ide.yaml".recursive = true;
  home.file.".config/tmuxp/tmuxp-ide.yaml".source = ./files/tmuxp-ide.yaml;
}
