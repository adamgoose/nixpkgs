{ pkgs, ... }: {

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      pane_frames = false;
    };
  };

}
