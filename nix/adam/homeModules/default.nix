{
  inputs,
  cell,
}: {
  default = {...}: {
    systemd.user.startServices = "sd-switch";
    home.stateVersion = "22.05";
  };

  bridge = import ./bridge.nix;

  thma = import ./thma.nix;
}
