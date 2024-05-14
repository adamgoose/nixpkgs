{
  inputs,
  lib,
  username,
  ...
}: let
  inherit (builtins) readDir;
in {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  users.users."${username}".openssh.authorizedKeys.keyFiles =
    lib.mapAttrsToList (file: type: inputs.self + /.ssh/${file})
    (lib.filterAttrs (file: type: type == "regular") (readDir (inputs.self + /.ssh)));
  users.users.root.openssh.authorizedKeys.keyFiles =
    lib.mapAttrsToList (file: type: inputs.self + /.ssh/${file})
    (lib.filterAttrs (file: type: type == "regular") (readDir (inputs.self + /.ssh)));
}
