{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      prefix-highlight
      vim-tmux-navigator
      {
        plugin = mkTmuxPlugin {
          pluginName = "catppuccin";
          version = "a98dc1e";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "8dd142b4e0244a357360cf87fb36c41373ab451f";
            sha256 = "sha256-KoGrA5Mgw52jU00bgirQb/E8GbsMkG1WVyS5NSFqv7o=";
          };
        };
      }
    ];
    tmuxp.enable = true;
    extraConfig = ''
      set -g mouse on
      set -g @catppuccin_flavour 'macchiato'
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
