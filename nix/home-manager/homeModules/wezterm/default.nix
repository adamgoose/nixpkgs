{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        enable_wayland = false,
        color_scheme = "Catppuccin Macchiato",
        font = wezterm.font 'FiraCode Nerd Font Mono',
        font_size = 16.0,

        enable_tab_bar = false,
        macos_window_background_blur = 30,
        window_decorations = 'RESIZE',

        window_background_opacity = .90,
        hide_mouse_cursor_when_typing = false,
      }
    '';
  };
}
