{ lib, buildGo118Module, fetchFromGitHub }:

buildGo118Module rec {
  pname = "oh-my-posh";
  version = "8.20.1";

  src = fetchFromGitHub {
    owner = "JanDeDobbeleer";
    repo = pname;
    rev = "v${version}";
    sha256 = "1lk1mmb154sm9swrlgm6aplfrr23yn4dbc7jy7x9y3925hxc4gg4";
  };
  
  modRoot = "./src";

  vendorSha256 = "sha256-t4FpvXsGVsTYoGM8wY2JelscnlmDzrLMPYk7zGUfo58=";

  # set the version.
  ldflags = [
    "-X main.Version=v${version}"
  ];

  meta = with lib; {
    description =
      "A prompt theme engine for any shell.";
    homepage = "https://github.com/JanDeDobbeleer/oh-my-posh";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
