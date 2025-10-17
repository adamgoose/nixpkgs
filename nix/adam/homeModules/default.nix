{
  inputs,
  cell,
}: {
  default = {...}: {
    systemd.user.startServices = "sd-switch";
    home.stateVersion = "22.05";
  };

  thma = import ./thma.nix;
}
