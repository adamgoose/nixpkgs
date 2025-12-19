{
  inputs,
  cell,
}: {
  default = inputs.nixpkgs;

  unstable = import inputs.nixpkgs-unstable {
    system = inputs.nixpkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
}
