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
    rev = "v3.5.2";
    sha256 = "sha256-RMBrHJ/HEzayZXnO0YH4AIupaNOF0MY1G9XJZg49QdE=";
  };

  home.file.".config/nvim/lua/user/".recursive = true;
  home.file.".config/nvim/lua/user/".source = ./files/astronvim;
}
