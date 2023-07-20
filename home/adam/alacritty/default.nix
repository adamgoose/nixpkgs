{ pkgs, ... }: {
  # home.packages = with pkgs; [
  #   alacritty
  # ];

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        startup_mode = "SimpleFullscreen";
      };
      font = {
        size = 16;
        normal = {
          family = "FiraCode Nerd Font Mono";
        };
      };
      import = [ "~/.config/alacritty/catppuccin/catppuccin-macchiato.yml" ];
    };
  };

  home.file.".config/alacritty/catppuccin/".source = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "alacritty";
    rev = "3c808cb";
    sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
  };
}
