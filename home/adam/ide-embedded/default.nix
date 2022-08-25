{ pkgs, ... }: {

  home.packages = with pkgs; [
    platformio
    esptool
  ];

}
