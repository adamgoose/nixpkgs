{ unstable, lib, ... }: {

  environment.systemPackages = with unstable; [
    lsof
    lm_sensors
    netdataCloud
  ];

  services.netdata = {
    enable = true;
    package = unstable.netdataCloud;

    config = {
      db = {
        mode = "dbengine";
        "storage tiers" = 2;
        "dbengine page descriptors in file mapped memory" = "yes";
        # storage tier 0
        "update every" = 1;
        "dbengine multihost disk space MB" = 12000;
        "dbengine page cache size MB" = 1400;
        # storage tier 1
        "dbengine tier 1 page cache size MB" = 512;
        "dbengine tier 1 multihost disk space MB" = 4096;
        "dbengine tier 1 update every iterations" = 60;
        "dbengine tier 1 backfill" = "new";
      };
    };

    configDir = {
      "stream.conf" = unstable.writeText "stream.conf" (lib.generators.toINI { } {
        "4e9b3ab2-5f43-40d2-8e43-6f09a289642d" = {
          enabled = "yes";
        };
      });
    };
  };
}
