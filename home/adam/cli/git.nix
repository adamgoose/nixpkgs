{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Adam Engebretson";
    userEmail = "adam@enge.me";
    ignores = [
      ".direnv"
    ];
  };

}
