{ pkgs, ... }:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "tmux";
    rev = "a0119d25283ba2b18287447c1f86720a255fb652";
    sha256 = "sha256-SGJjDrTrNNxnurYV1o1KbHRIHFyfmbXDX/t4KN8VCao=";
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
      resurrect
      continuum
      prefix-highlight
      vim-tmux-navigator
      {
        plugin = mkTmuxPlugin {
          pluginName = "catppuccin";
          version = "a0119d2";
          src = catppuccinSrc;
        };
        extraConfig = ''
          set -g @catppuccin_flavour 'macchiato'

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator "█ "
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#{b:pane_current_path}"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#{b:pane_current_path}#{?window_zoomed_flag, 󰛭,}"

          set -g @catppuccin_status_modules_right 'directory date_time session'
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
    ];
    extraConfig = ''
      set -g base-index 1
      set -g renumber-windows on
      set -g status-position top
      set -g pane-border-status top
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

}
