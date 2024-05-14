{
  inputs,
  cell,
}: {
  default = {...}: {
    nixpkgs.config.allowUnfree = true;
    systemd.user.startServices = "sd-switch";
    home.stateVersion = "22.05";
  };

  bridge = import ./bridge.nix;
}
