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
        diff.tool = ["difft" "--color=always" "$left" "$right"];
      };
    };
  };

  home.packages = with pkgs; [
    jjui
    difftastic
  ];
}
