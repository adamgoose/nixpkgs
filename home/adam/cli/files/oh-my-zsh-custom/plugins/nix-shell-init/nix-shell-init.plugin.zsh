## This is my plugin, but it's empty

nixshellinit() {
  channel=${1:-"22.05"}
  releaseSha=$(curl -s https://channels.nix.gsc.io/nixos-${channel}/latest-v2 | awk '{printf "%s",$1}')

  cat << EOF
# nixshellinit ${channel}
# $(date)
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/${releaseSha}.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    //
  ];
}
EOF
}
