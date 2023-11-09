{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Adam Engebretson";
    userEmail = "adam@enge.me";
    ignores = [
      ".direnv"
    ];
    extraConfig = {
      ghq = {
        root = "~/src";
      };
    };
  };

  home.packages = with pkgs; [
    ghq
  ];
}
