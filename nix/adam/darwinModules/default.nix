{ inputs, cell }:
let
  inherit (inputs.cells) home-manager;
in
{

  default = { pkgs, username, ... }: {
    nix = {
      useDaemon = true;
      settings = {
        trusted-users = [ "root" username ];
      };
      extraOptions = ''
        experimental-features = nix-command flakes repl-flake
      '';
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    programs.zsh.enable = true;
    environment = {
      shells = [ pkgs.zsh ];
      loginShell = pkgs.zsh;
    };

    users.users.${username} = {
      name = username;
      home = "/Users/${username}";
    };

    system.stateVersion = 4;
  };

  bridge = { unstable, ... }:
    let
      pkgs = unstable;
      cabundle = pkgs.cacert.override {
        extraCertificateFiles = [ ./netskope_ca.pem ];
      };
    in
    {
      nix = {
        extraOptions = ''
          ssl-cert-file = ${cabundle}/etc/ssl/certs/ca-bundle.crt
        '';
      };
    };

  home = modules:
    home-manager.darwinModules.mkDarwinModule ([
      cell.homeModules.default
    ] ++ modules);

}
