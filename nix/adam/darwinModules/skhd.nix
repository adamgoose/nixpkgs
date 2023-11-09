{ ... }: {

  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt + shift - return : yabai -m window --swap first
      # alt + cmd - space : open -a alacritty
    '';
  };

}
