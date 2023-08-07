{ pkgs, username, ... }: {
  services.syncthing = {
    enable = true;
  };
}
