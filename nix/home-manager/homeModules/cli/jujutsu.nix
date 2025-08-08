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
      ui = {
        paginate = "never";
        default-command = "log";
      };
    };
  };

  home.packages = with pkgs; [
    lazyjj
  ];

  home.shellAliases = {
    lj = "lazyjj";
  };
}
