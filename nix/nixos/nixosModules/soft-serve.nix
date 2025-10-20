{
  unstable,
  inputs,
  ...
}: {
  services.soft-serve = {
    enable = true;
    package = unstable.soft-serve;
    settings = {
      initial_admin_keys = [
        (builtins.readFile (inputs.self + "/.ssh/adam@home_id_ed25519.pub"))
      ];
    };
  };
}
