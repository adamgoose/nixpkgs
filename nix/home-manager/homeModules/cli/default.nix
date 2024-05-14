{
  pkgs,
  username,
  ...
}: rec {
  imports = [
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./zellij.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    jq
    enc
    gum
    btop
    htop
    wget
    xplr
    yazi
    doggo
    unzip
    watch
    cachix
    httpie
    rclone
    hostctl
    neofetch
  ];

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./files/.omp.json));
  };

  xdg.enable = true;

  home.file.".config/btop/btop.conf".text = ''
    color_theme = "/home/${username}/.config/btop/themes/catppuccin_macchiato.theme";
    vim_keys = True
  '';
  home.file.".config/btop/themes".recursive = true;
  home.file.".config/btop/themes".source =
    pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "btop";
      rev = "89ff712eb62747491a76a7902c475007244ff202";
      sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
    }
    + "/themes";
}
