{ lib, buildGoModule, fetchFromGitHub, fetchgit, openssh }:

buildGoModule rec {
  pname = "truss-local";
  version = "0.0.9";

  buildInputs = [ openssh ];

  # src = fetchgit {
  #   url = "git@github.com:get-bridge/truss-local.git";
  #   sha256 = "";
  # };
  src = fetchFromGitHub {
    owner = "get-bridge";
    repo = "truss-local";
    rev = "v${version}";
    private = true;
    sha256 = "";
  };

  doCheck = false;

  vendorSha256 = "";
  ldflags = ["-s -w -X github.com/get-bridge/truss-local/cmd.Version=${version}"];

  meta = with lib; {
    homepage = "https://github.com/get-bridge/truss-local";
    description = "CLI to run Truss apps locally";
    platforms = platforms.linux ++ platforms.darwin;
    # license = licenses.mit;
    # maintainers = [ (import ../../../../maintainers/maintainer-list.nix).craun ];
  };
}
