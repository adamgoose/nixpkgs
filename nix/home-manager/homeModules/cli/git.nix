{
  pkgs,
  unstable,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Adam Engebretson";
        email = "adam@enge.me";
      };
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
      ghq = {
        root = "~/src";
      };
    };
    ignores = [
      ".direnv"
    ];
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
        diff-formatter = ["difft" "--color=always" "$left" "$right"];
      };
    };
  };

  home.packages = with pkgs; [
    ghq
    difftastic
    unstable.jjui
  ];
}
