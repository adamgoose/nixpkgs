{config, ...}: {
  home.shell.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };

    shellAliases = config.home.shellAliases;
  };

  programs.eza.enableNushellIntegration = true;
  programs.yazi.enableNushellIntegration = true;
  programs.atuin.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
}
