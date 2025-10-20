{
  pkgs,
  # config,
  ...
}: {
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
      # default_shell = pkgs.nushell + /bin/nu;
    };
  };

  xdg.configFile."ghostty/config".text = ''
    command = ${pkgs.zellij}/bin/zellij attach --create
  '';
}
