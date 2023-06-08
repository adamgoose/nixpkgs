{ unstable, lib, ... }: {
  home.packages = with unstable; [
    tailscale
    podman
    podman-compose
    qemu
  ]

  # The 1Password CLI Must exist in /usr/local/bin on Mac for biometric unlock
  # to work, so manual installation is required.
  ++ lib.lists.optional (!stdenv.isDarwin) _1password

  ;
}
