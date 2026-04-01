{inputs, ...}: {
  imports = [
    inputs.nix-openclaw.homeManagerModules.openclaw
    ./personal.nix
    ./sato48.nix
  ];

  programs.openclaw = {
    exposePluginPackages = false;
  };
}
