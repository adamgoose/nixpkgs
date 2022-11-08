{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "truss-cli";
  version = "0.2.9";

  src = fetchFromGitHub {
    owner = "get-bridge";
    repo = "truss-cli";
    rev = "v${version}";
    sha256 = "sha256-1juywK1jm4d+Dgiv3UpwZiqCfuhLu0B5/7BYZKQ3ukY=";
  };

  doCheck = false;

  vendorSha256 = "sha256-0nEYN1qEhMSyhXZIZjmg76PKiadBe94Z42cX8klqt0c=";
  ldflags = ["-s -w -X github.com/get-bridge/truss-cli/cmd.Version=${version}"];

  postInstall = ''
    mv $out/bin/truss-cli $out/bin/truss
  '';

  meta = with lib; {
    homepage = "https://github.com/get-bridge/truss-cli";
    description = "CLI to help you manage many k8s clusters";
    platforms = platforms.linux ++ platforms.darwin;
    license = licenses.mit;
    # maintainers = [ (import ../../../../maintainers/maintainer-list.nix).craun ];
  };
}
