{ pkgs, ... }: {
  imports = [
    # ./neovim.nix
    ./astrovim.nix
  ];

  home.packages = with pkgs; [
    rnix-lsp
    lazygit
    ripgrep

    nodejs
  ];

  home.shellAliases = {
    lg = "lazygit";
  };
}
