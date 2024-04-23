{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  home.file.".config/nvim".recursive = true;
  home.file.".config/nvim".source = ./astrovim;

}
