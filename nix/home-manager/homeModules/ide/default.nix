{pkgs, ...}: {
  imports = [
    ./astrovim.nix
  ];

  home.packages = with pkgs; [
    nil
    gcc
    nodejs
    statix
    deadnix
    lazygit
    ripgrep
    alejandra
    tree-sitter
  ];

  home.shellAliases = {
    lg = "lazygit";
  };

  home.sessionVariables = {
    NODE_VERSIONS = "$HOME/.nvm/versions/node";
    NODE_VERSION_PREFIX = "v";
  };

  programs.zsh.oh-my-zsh.plugins = ["npm" "nvm"];
  programs.zsh.zplug.plugins = [
    {
      name = "lukechilds/zsh-nvm";
    }
  ];
}
