{lib, ...}: {
  programs.git = {
    settings = {
      user = {
        email = lib.mkForce "aengebretson@hmacademy.com";
      };
    };
  };

  programs.jujutsu = {
    settings = {
      user = {
        email = lib.mkForce "aengebretson@hmacademy.com";
      };
    };
  };
}
