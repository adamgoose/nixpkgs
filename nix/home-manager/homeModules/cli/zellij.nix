{pkgs, ...}: let
  tomlFormat = pkgs.formats.toml {};
in {
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
    };
  };

  ##
  # sidebar is an alias to a specialized configuration of yazi, a file browser.
  #
  # Pressing "enter" on a file in the sidebar will either open the file in Helix,
  # or create a new pane opening the file in Helix.
  #
  # Example workflow:
  # - Spawn Zellij or new tab with a single pane
  # - `cd` to your project
  # - Run `sidebar`
  # - Find a file to work on
  # - Press "enter"
  # - Ctrl + n, spam j, Esc - to resize the new pane so the sidebar feels like a sidebar
  # - Alt + j to focus the sidebar, find another file, press enter
  # - Editing bliss
  #
  programs.nushell.enable = true;
  home.shellAliases.sidebar = "YAZI_CONFIG_HOME=~/.config/yazi/sidebar yazi";
  xdg.configFile."yazi/sidebar/yazi.toml".source = tomlFormat.generate "yazi-sidebar-settings" {
    manager = {
      ratio = [0 8 0];
    };
    opener = {
      edit = [
        {
          desc = "Open in Helix";
          run = "nu ${./files/open_file.nu} \"$1\"";
        }
      ];
    };
  };

  xdg.configFile."ghostty/config".text = ''
    command = ${pkgs.zellij}/bin/zellij attach --create
  '';
}
