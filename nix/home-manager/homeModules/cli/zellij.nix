{
  pkgs,
  unstable,
  ...
}: {
  programs.zellij = {
    enable = true;
    package = unstable.zellij;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
    };
  };

  xdg.configFile."ghostty/config".text = ''
    command = ${pkgs.zellij}/bin/zellij attach --create
  '';
}
