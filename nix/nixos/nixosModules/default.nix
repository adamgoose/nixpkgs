{ inputs, cell }:

{

  k3s = import ./k3s.nix;
  nfs = import ./nfs.nix;
  ssh = import ./ssh.nix;
  hyprland = import ./hyprland.nix;
  bluetooth = import ./bluetooth.nix;
  tailscale = import ./tailscale.nix;
  pulseaudio = import ./pulseaudio.nix;

}
