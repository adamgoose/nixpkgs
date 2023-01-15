{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "enc";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "life4";
    repo = "enc";
    rev = "${version}";
    sha256 = "sha256-Tt+J/MnYJNewSl5UeewS0b47NGW2yzfcVHA5+9UQWSs=";
  };

  vendorSha256 = "sha256-7PLP3DVtGCStRWzLOrW+vEG5Y7/nevHFzYVf/vrELbA=";

  meta = with lib; {
    homepage = "https://github.com/life4/enc";
    description = "A modern and friendly CLI alternative to GnuPG: generate and download keys, encrypt, decrypt, and sign text and files, and more.";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
