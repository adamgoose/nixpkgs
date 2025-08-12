{pkgs, ...}: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./zsh.nix
    ./zellij.nix
    # ./nushell.nix
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
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.yazi.enable = true;
  programs.atuin.enable = true;
  programs.atuin.settings = {
    invert = true;
    inline_height = 20;
    enter_accept = false;
    search_mode_shell_up_key_binding = "prefix";
  };

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      gcloud.disabled = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
    nixpkgs = "cd ~/src/github.com/adamgoose/nixpkgs";
    http = "curlie";
    https = "curlie";
  };
}
