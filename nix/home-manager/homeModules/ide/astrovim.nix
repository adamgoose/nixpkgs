{ pkgs, ... }:

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
    rev = "v3.37.12";
    sha256 = "sha256-cC1isyscpvNQ07n/Eb6rlfvuQ/K+7mCjdGJq4m/PUHk=";
  };

  home.file.".config/nvim/lua/user/".recursive = true;
  home.file.".config/nvim/lua/user/".source = ./files/astronvim;
}
