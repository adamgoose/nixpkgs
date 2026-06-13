{
  inputs,
  cell,
}: {
  default = {...}: {
    systemd.user.startServices = "sd-switch";
    home.stateVersion = "22.05";

    home.sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  thma = import ./thma.nix;
}
