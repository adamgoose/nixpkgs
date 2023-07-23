{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kitty
    tmux
    brightnessctl
    ungoogled-chromium
  ];

  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    # nvidia.modesetting.enable = true;
  };
}
