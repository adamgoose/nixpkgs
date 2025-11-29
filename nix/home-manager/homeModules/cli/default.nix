{
  lib,
  pkgs,
  inputs,
  unstable,
  ...
}: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./zsh.nix
    ./zellij.nix
    ./nushell.nix
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
    unstable.ncspot
    inputs.starship-jj.packages.${pkgs.system}.default
  ];

  xdg.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.yazi.enable = true;
  programs.atuin = {
    enable = true;
    settings = {
      invert = true;
      inline_height = 20;
      enter_accept = false;
      filter_mode = "workspace";
      search_mode_shell_up_key_binding = "prefix";
    };
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

      format = lib.mkForce "$username$directory\${custom.jj-branch}\${custom.jj-delta}\${custom.jj-description}\${custom.jj-stats-files}\${custom.jj-stats-additions}\${custom.jj-stats-removals}$fill$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$scala$conda$python$time\n  [󱞪](fg:iris) ";

      custom.jj-branch = {
        format = "[](fg:overlay)[ ](bg:overlay fg:iris)[$output]($style)";
        style = "bg:overlay fg:pine";
        command = "branch";
        shell = [(pkgs.nushell + /bin/nu) ./files/jj-starship.nu];
        detect_folders = [".jj"];
      };

      custom.jj-delta = {
        format = "[$output ]($style)";
        style = "bg:overlay fg:love";
        command = "delta";
        shell = [(pkgs.nushell + /bin/nu) ./files/jj-starship.nu];
        detect_folders = [".jj"];
      };

      custom.jj-description = {
        format = "[$output ]($style)";
        style = "bg:overlay fg:white";
        command = "description";
        shell = [(pkgs.nushell + /bin/nu) ./files/jj-starship.nu];
        detect_folders = [".jj"];
      };
      custom.jj-stats-files = {
        format = "[$output ]($style)";
        style = "bg:overlay fg:gold";
        command = "files";
        shell = [(pkgs.nushell + /bin/nu) ./files/jj-starship.nu "stats"];
        detect_folders = [".jj"];
      };
      custom.jj-stats-additions = {
        format = "[$output]($style)";
        style = "bg:overlay fg:foam";
        command = "additions";
        shell = [(pkgs.nushell + /bin/nu) ./files/jj-starship.nu "stats"];
        detect_folders = [".jj"];
      };
      custom.jj-stats-removals = {
        format = "[$output]($style)[](fg:overlay) ";
        style = "bg:overlay fg:love";
        command = "removals";
        shell = [(pkgs.nushell + /bin/nu) ./files/jj-starship.nu "stats"];
        detect_folders = [".jj"];
      };
    };
  };

  home.shellAliases = {
    cat = "bat";
    nixpkgs = "cd ~/src/github.com/adamgoose/nixpkgs";
    http = "curlie";
    https = "curlie";
  };
}
