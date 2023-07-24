{ lib, ... }:

let
  inherit (builtins) readDir;
in
{

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  users.users.adam.openssh.authorizedKeys.keyFiles = lib.mapAttrsToList (file: type: ../../.ssh/${file})
    (lib.filterAttrs (file: type: type == "regular") (readDir ../../.ssh));

}
