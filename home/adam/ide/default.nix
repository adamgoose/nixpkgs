{ pkgs, ... }: {
  imports = [
    # ./neovim.nix
    ./astrovim.nix
  ];

  home.packages = with pkgs; [
    nodejs
    lazygit
    ripgrep
    rnix-lsp
    tree-sitter
  ];

  home.shellAliases = {
    lg = "lazygit";
  };
}
