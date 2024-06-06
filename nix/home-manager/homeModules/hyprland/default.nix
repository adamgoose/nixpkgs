{ pkgs, unstable, inputs, ... }:
let
  catppuccin-rofi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "rofi";
    rev = "5350da4";
    sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
  };

  catppuccin-hyprland = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprland";
    rev = "99a88fd";
    sha256 = "sha256-07B5QmQmsUKYf38oWU3+2C6KO4JvinuTwmW1Pfk8CT8=";
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    sourceFirst = true;
    settings = {
      exec-once = [
        # "ags"dunst"
        "hyprpaper"
      ];

      source = [ (catppuccin-hyprland + "/themes/macchiato.conf") ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.inactive_border" = "$overlay0";
        "col.active_border" = "$mauve $pink 45deg";
        layout = "master";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = "yes";
          size = 3;
          passes = 1;
          new_optimizations = "on";
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "$surface0";
      };

      "$mod" = "SUPER";
      bind = [
        "$mod ALT, space, exec, wezterm"
        "$mod, space, exec, rofi -show drun"
        "$mod, escape, exec, hyprlock"
        ", XF86AudioRaiseVolume, exec, pamixer --increase 5"
        ", XF86AudioLowerVolume, exec, pamixer --decrease 5"
        ", XF86AudioMute, exec, pamixer --toggle-mute"

        "$mod, M, exit"
        "$mod, W, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"
        "ALT SHIFT, return, layoutmsg, swapwithmaster auto"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
      ] ++ (
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

      bindm = [
        "$mod, mouse:272, resizewindow"
        "$mod SHIFT, mouse:272, movewindow"
      ];

      windowrule = [
        "float, 1Password"

        "float, mpv"
        "pin, mpv"
        "maxsize 1920 1080, mpv"
        "center 1, mpv"
      ];
    };
  };

  home.packages = with pkgs; with gnome; [
    fd
    bun
    dart-sass
    unstable.morewaita-icon-theme

    slurp
    wf-recorder

    gnome-calendar
    gnome-boxes
    gnome-system-monitor
    gnome-control-center
    gnome-weather
    gnome-calculator
    gnome-clocks
    nautilus

    mpv

    dunst
    qtemu
    slack
    steam
    baobab
    discord
    pamixer
    spotify
    cliphist
    gnome.eog
    hyprpaper
    playerctl
    hyprpicker
    wl-clipboard
    signal-desktop
    beekeeper-studio
    plex-media-player
    unstable.hyprlock
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Macchiato-Pink-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoPink;
    };
    iconTheme = {
      name = "MoreWaita";
      package = unstable.morewaita-icon-theme;
    };
    font.name = "FireCode Nerd Font";
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        offset = "10x10";
        separator_height = 2;
        padding = 12;
        horizontal_padding = 12;
        text_icon_padding = 12;
        frame_width = 4;
        separator_color = "frame";
        idle_threshold = 120;
        font = "FiraCode Nerd Font 12";
        line_height = 0;
        format = "<b>%s</b><br>%b";
        alignment = "center";
        icon_position = "off";
        startup_notification = "false";
        corner_radius = 12;

        frame_color = "#44465c";
        background = "#303241";
        foreground = "#d9e0ee";
        timeout = 2;
      };
    };
  };

  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font 16";
    terminal = "${unstable.wezterm}/bin/wezterm";
  };

  # imports = [ inputs.ags.homeManagerModules.default ];
  # programs.ags = {
  #   enable = true;
  #   # configDir = ./.ags;
  # };

  home.file.".config/face.png".source = inputs.self + "/face.png";
  home.file.".config/face.jpg".source = inputs.self + "/face.jpg";
  home.file.".config/background.png".source = inputs.self + "/wallpaper.png";
  home.file.".config/background.jpg".source = inputs.self + "/wallpaper.jpg";

  home.file.".config/hypr".recursive = true;
  home.file.".config/hypr".source = ./.hypr;
  home.file.".config/hypr/macchiato.conf".source = catppuccin-hyprland + "/themes/macchiato.conf";

  home.file.".config/rofi".recursive = true;
  home.file.".config/rofi".source = catppuccin-rofi + "/basic/.config/rofi";
  home.file.".local/share/rofi/themes".recursive = true;
  home.file.".local/share/rofi/themes".source = catppuccin-rofi + "/basic/.local/share/rofi/themes";
}
