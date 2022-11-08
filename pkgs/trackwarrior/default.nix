{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "trackwarrior";

  src = fetchgit {
    url = "https://github.com/gkssjovi/trackwarrior.git";
    sparseCheckout = ''
      taskwarrior
      timewarrior
    '';
    sha256 = "sha256-BOxAn8lEllBEqHhRBaBwx9S4aBTlLD+0ZzqHMWOeFFw=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/taskwarrior
    mkdir -p $out/timewarrior
    cp -r taskwarrior/hooks $out/taskwarrior
    cp -r timewarrior/extensions $out/timewarrior
  '';
}
