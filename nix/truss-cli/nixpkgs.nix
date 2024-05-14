{
  inputs,
  cell,
}: {
  default = inputs.nixpkgs;

  unstable = import inputs.nixpkgs-unstable {
    system = inputs.nixpkgs.system;
  };
}
