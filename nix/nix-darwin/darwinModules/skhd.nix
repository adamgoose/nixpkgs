{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    skhd
  ];

  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt + shift - return : yabai -m window --swap first
      alt + cmd - space : sh ${./wezbar.sh}
      # alt + cmd - space : open -a alacritty
    '';
  };

}
