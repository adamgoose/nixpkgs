{
  pkgs,
  # inputs,
  ...
}:
# let
#   zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
# in
{
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      plugins = {
        # zjstatus = {
        #   _props = {
        #     location = "file:${zjstatus}/bin/zjstatus.wasm";
        #   };
        # };
      };
    };
  };

  # xdg.configFile."zellij/layouts/default.kdl".source = ./files/zellij-layout.kdl;
  # xdg.configFile."zellij/layouts/default.swap.kdl".source = ./files/zellij-layout.swap.kdl;

  xdg.configFile."ghostty/config".text = ''
    command = ${pkgs.zellij}/bin/zellij attach --create
  '';
}
