{ pkgs, lib, ... }: {

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      pane_frames = false;
    };
  };

  programs.zsh.initExtra = lib.mkOrder 200 ''
    eval "$(${lib.getExe pkgs.zellij} setup --generate-completion zsh)"
  '';

}
