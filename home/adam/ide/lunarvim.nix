{ pkgs, unstable, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nord-nvim
      vim-tmux-navigator
    ] ++ (with unstable.vimPlugins; [
      # ...
    ]);
  };

  home.file.".config/nvim".recursive = true;
  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "LunarVim";
    repo = "LunarVim";
    rev = "1.2.0";
    sha256 = "sha256-xlQ4qOUG1+wXyr1xVO2Mni/L3bKyrIlPFmve5w2Xoss=";
  };

  home.file.".config/nvim/config.lua".source = ./files/lunarvim.lua;
}
