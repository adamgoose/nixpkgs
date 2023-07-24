{ username, pkgs, features, ... }:

let
  inherit (builtins) map pathExists filter;
in
{

  imports = filter pathExists (map (feature: ./${feature}) features);

  nix = {
    useDaemon = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-users = root adam
    '';
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [ qemu ];
    pathsToLink = [ "/share/qemu" ];
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
    montserrat
  ];

  system.defaults = {
    dock.autohide = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder._FXShowPosixPathInTitle = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 4;
}

