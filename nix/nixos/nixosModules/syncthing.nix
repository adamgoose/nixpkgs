{ username, ... }: {
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";

    settings = {
      folders."pgp" = {
        enable = true;
        path = "/var/lib/syncthing/${username}/.pgp-sync";
      };

      folders."default" = {
        enable = true;
        path = "/var/lib/syncthing/${username}/Sync";
      };

      devices."adams-macbook-pro" = {
        introducer = true;
        id = "VJ2QN2Y-ORA6LH4-VNTYILJ-VNLRQEC-FVT7MNM-WXLBB3U-JBZ7X2F-PTIWOAZ";
        addresses = [ "tcp://adams-macbook-pro:22000" ];
      };
    };
  };

  users.users.${username}.extraGroups = [ "syncthing" ];
}
