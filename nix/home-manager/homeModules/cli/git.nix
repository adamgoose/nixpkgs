{
  pkgs,
  unstable,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Adam Engebretson";
    userEmail = "adam@enge.me";
    ignores = [
      ".direnv"
    ];
    extraConfig = {
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
      ghq = {
        root = "~/src";
      };
    };
  };

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
        diff.tool = ["difft" "--color=always" "$left" "$right"];
      };
    };
  };

  home.packages = with pkgs; [
    ghq
    jjui
    difftastic
  ];
}
