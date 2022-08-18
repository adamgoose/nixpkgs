{ lib, ... }:

let
  inherit (builtins) readDir;
in
{

  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = true;
  };

  users.users.adam.openssh.authorizedKeys.keyFiles = lib.mapAttrsToList (file: type: ../../.ssh/${file})
    (lib.filterAttrs (file: type: type == "regular") (readDir ../../.ssh));

}
