{ pkgs, ... }: {
  imports = [
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    lazygit
    ripgrep

    nodejs
  ];

  home.shellAliases = {
    lg = "lazygit";
  };
}
