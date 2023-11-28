{ inputs, system, username, ... }: {

  services.hlsdl = {
    enable = true;
    user = username;
  };

}
