{ pkgs, unstable, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nord-nvim
    ] ++ (with unstable.vimPlugins; [
      copilot-vim
    ]);
  };

  home.file.".config/nvim".recursive = true;
  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v2.11.8";
    sha256 = "sha256-fpKrB6LW5KlQx/Egv5QY0hnzDGtJqmaXOzQevllVdjI=";
  };

  home.file.".config/nvim/lua/user/init.lua".source = ./files/init.lua;
}
