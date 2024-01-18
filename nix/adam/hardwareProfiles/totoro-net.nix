{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "159.203.56.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="159.203.57.0"; prefixLength=21; }
{ address="10.20.0.6"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::c1b:22ff:fe91:78ca"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "159.203.56.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.118.16.2"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::7c9d:31ff:fe91:7fb9"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="0e:1b:22:91:78:ca", NAME="eth0"
    ATTR{address}=="7e:9d:31:91:7f:b9", NAME="eth1"
  '';
}
