{ username, pkgs, ... }: {

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
    NSGlobalDomain._HIHideMenuBar = true;
  };

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    launchctl stop org.nixos.skhd
  '';

  security.pam.enableSudoTouchIdAuth = true;

  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";
      external_bar = "main:26:0";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      display = "main";
      text_font = ''"FiraCode Nerd Font":Regular:16.0'';
      icon_font = ''"FiraCode Nerd Font":Regular:16.0'';
    };
    # extraConfig = "";
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt + shift - return : yabai -m window --swap first
      # alt + cmd - space : open -a alacritty
    '';
  };


  system.stateVersion = 4;
}

