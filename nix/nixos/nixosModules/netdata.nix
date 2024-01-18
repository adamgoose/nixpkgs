{ unstable, ... }: {

  environment.systemPackages = with unstable; [
    lsof
    lm_sensors
    netdataCloud
  ];

  services.netdata = {
    enable = true;
    package = unstable.netdataCloud;
  };

}
