{ pkgs, ... }: {

  home.packages = with pkgs; [
    tasksh
    taskwarrior
    timewarrior
    trackwarrior
  ];

  home.file.".task/hooks".source = "${pkgs.trackwarrior}/taskwarrior/hooks";
  home.file.".task/hooks".recursive = true;
  home.file.".timewarrior/extensions".source = "${pkgs.trackwarrior}/timewarrior/extensions";
  home.file.".timewarrior/extensions".recursive = true;

  programs.zsh.oh-my-zsh.plugins = [ "taskwarrior" ];
}
