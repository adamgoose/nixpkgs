{ inputs, system, username, ... }: {

  services.hlsdl = {
    enable = true;
    user = username;
    out = "/mnt/mildred/Rancher/stash/media/hlsdl";
  };

}
