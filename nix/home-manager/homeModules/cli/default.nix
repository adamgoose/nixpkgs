{pkgs, ...}: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./zsh.nix
    ./atuin.nix
    ./zellij.nix
  ];
  home.packages = with pkgs; [
    fx
    jq
    enc
    gum
    htop
    mosh
    wget
    doggo
    unzip
    watch
    cachix
    curlie
    rclone
    jwt-cli
    posting
    neofetch
  ];

  xdg.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR --mouse";
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.shellAliases = {
    cat = "bat";
    nixpkgs = "cd ~/src/github.com/adamgoose/nixpkgs";
    http = "curlie";
    https = "curlie";
  };
}
