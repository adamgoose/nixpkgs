{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kitty
    brave
    tmux
    brightnessctl
  ];

  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };

  hardware = {
    opengl.enable = true;
    # nvidia.modesetting.enable = true;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

}
