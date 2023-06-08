{ pkgs, unstable, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nord-nvim
      vim-tmux-navigator
    ] ++ (with unstable.vimPlugins; [
      copilot-vim
    ]);
  };

  home.file.".config/nvim".recursive = true;
  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v3.19.1";
    sha256 = "sha256-ss2f6QrT6h5vGih5F8E3KEjmDUCS1qLB3Z+2ZICxh+0=";
  };

  home.file.".config/nvim/lua/user/".recursive = true;
  home.file.".config/nvim/lua/user/".source = ./files/astronvim;
}
