{ username, pkgs, features, ... }:

let
  inherit (builtins) map pathExists filter;
in
{

  imports = filter pathExists (map (feature: ./${feature}) features);

  nix = {
    useDaemon = true;
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
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
    dock.mru-spaces = false;
    dock.show-recents = false;
    dock.wvous-bl-corner = 4; # Desktop
    dock.wvous-br-corner = 2; # Mission Control
    dock.wvous-tr-corner = 5; # Start Screen Saver
    dock.wvous-tl-corner = 6; # Disable Screen Saver
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder._FXShowPosixPathInTitle = true;
    trackpad.Clicking = true;
    trackpad.Dragging = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 4;
}

