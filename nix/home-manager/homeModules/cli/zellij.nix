{
  pkgs,
  ...
}:
{
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
    };
  };


  xdg.configFile."ghostty/config".text = ''
    command = ${pkgs.zellij}/bin/zellij attach --create
  '';
}
