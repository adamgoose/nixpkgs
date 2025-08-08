{
  pkgs,
  unstable,
  ...
}: {
  programs.jujutsu = {
    enable = true;
    package = unstable.jujutsu;
    settings = {
      user = {
        name = "Adam Engebretson";
        email = "adam@enge.me";
      };
    };
  };

  home.packages = with pkgs; [
    lazyjj
  ];
}
