{ unstable, ... }: {

  services.netdata = {
    enable = true;
    package = unstable.netdata;
  };

}
