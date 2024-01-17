{ unstable, ... }: {

  environment.systemPackages = with unstable; [
    lsof
    lm_sensors
  ];

  services.netdata = {
    enable = true;
    package = unstable.netdata;
  };

}
