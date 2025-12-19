{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.hlsdl.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.sessionVariables = {
    HLSDL_REDIS_ADDR = "roxie:6379";
  };
}
