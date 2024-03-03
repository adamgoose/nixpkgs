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
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
      ghq = {
        root = "~/src";
      };
    };
  };

  home.packages = with pkgs; [
    ghq
  ];
}
