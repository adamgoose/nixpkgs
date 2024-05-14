{...}: {
  fileSystems."/mnt/mildred" = {
    fsType = "nfs";
    device = "10.0.2.6:/";
  };
}
