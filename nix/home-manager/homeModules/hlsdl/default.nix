{ pkgs, inputs, ... }: rec {

  home.packages = [
    inputs.hlsdl.packages.${pkgs.system}.default
  ];

  home.sessionVariables = {
    HLSDL_REDIS_ADDR = "roxie:6379";
  };

}
