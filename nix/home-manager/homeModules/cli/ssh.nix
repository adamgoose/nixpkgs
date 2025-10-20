{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      mildred = {
        user = "admin";
      };
      soft = {
        hostname = "totoro";
        port = 23231;
      };
    };
  };
}
