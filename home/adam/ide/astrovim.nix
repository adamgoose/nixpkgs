{ pkgs, unstable, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-tmux-navigator
    ];
  };

  home.file.".config/nvim".recursive = true;
  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v3.33.4";
    sha256 = "sha256-utGG1U9p3a5ynRcQys1OuD5J0LjkIQipD0TX8zW66/4=";
  };

  home.file.".config/nvim/lua/user/".recursive = true;
  home.file.".config/nvim/lua/user/".source = ./files/astronvim;
}
