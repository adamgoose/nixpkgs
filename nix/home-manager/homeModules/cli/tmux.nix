{ pkgs, ... }:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "tmux";
    rev = "47e33044b4b47b1c1faca1e42508fc92be12131a";
    sha256 = "sha256-kn3kf7eiiwXj57tgA7fs5N2+B2r441OtBlM8IBBLl4I=";
  };

  catppuccinSrc = pkgs.runCommand "build-catppuccin-tmux" { } ''
    mkdir $out
    cp -r ${catppuccin}/* $out/
    chmod +w $out/custom
    cp -r ${./files/catppuccin-tmux}/* $out/custom/
  '';
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      prefix-highlight
      vim-tmux-navigator
      {
        plugin = mkTmuxPlugin {
          pluginName = "catppuccin";
          version = "47e3304";
          src = catppuccinSrc;
        };
        extraConfig = ''
          set -g @catppuccin_flavour 'macchiato'
          set -g @catppuccin_status_modules_right 'weather date_time session'
        '';
      }
    ];
    tmuxp.enable = true;
    extraConfig = ''
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
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
