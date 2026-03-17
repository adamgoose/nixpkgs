{
  pkgs,
  username,
  ...
}: {
  services.protonmail-bridge = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "protonmail-bridge";
      paths = [ pkgs.protonmail-bridge ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/protonmail-bridge \
          --prefix PATH : ${pkgs.lib.makeBinPath [
            (pkgs.writeShellScriptBin "pass" ''
              args=()
              for arg in "$@"; do
                args+=("''${arg%.age}")
              done
              exec ${pkgs.passage}/bin/passage "''${args[@]}"
            '')
          ]} \
          --set PASSWORD_STORE_DIR "/home/${username}/.passage/store"
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    passage
  ];

  sops.secrets = {
    "protonmail-bridge/ageKey" = {
      owner = username;
      path = "/home/${username}/.passage/identities";
    };
  };
}
