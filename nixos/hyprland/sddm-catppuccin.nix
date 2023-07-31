{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "sddm-catppuccin";
  version = "";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "bde6932";
    sha256 = "sha256-ceaK/I5lhFz6c+UafQyQVJIzzPxjmsscBgj8130D4dE=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/
    cp -r src/* $out/share/sddm/themes/
  '';
}
