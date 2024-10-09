{pkgs, ...}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      delve
      gopls
      terraform-ls
      lua-language-server
      yaml-language-server
      nodePackages.typescript-language-server
    ];
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        line-numbers = "relative";
      };
    };
  };
}
