{
  inputs,
  cell,
}: {
  default = import inputs.nixpkgs {
    system = inputs.nixpkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
    overlays = [
      inputs.nix-openclaw.overlays.default
    ];
  };

  unstable = import inputs.nixpkgs-unstable {
    system = inputs.nixpkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
    overlays = [
      inputs.nix-openclaw.overlays.default
    ];
  };
}
