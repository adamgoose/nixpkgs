{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      mildred = {
        user = "admin";
      };
    };
  };
}
