{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "risor";
  version = "0.17.0";

  src = fetchFromGitHub {
    owner = "risor-io";
    repo = "risor";
    rev = "v${version}";
    sha256 = "sha256-/7jUz2180m+YVyE9z4UKOhVv0DSqrCWdkyAftluMHeo=";
  };

  modRoot = "./cmd/risor";

  vendorSha256 = "sha256-xYd8QB6DxzKtmvdEF4PBKdi5E3HRfMP/cCWZ5QA85Ls=";

  GOWORK = "off";
  doCheck = false;

  ldflags = [
    "-X github.com/risor-io/risor/cmd/risor.version=${version}"
    "-s"
    "-w"
  ];

  postInstall = ''
    mkdir -p $out/share/{bash-completion/completions,zsh/site-functions}
    export HOME=$PWD
    $out/bin/risor completion bash > $out/share/bash-completion/completions/risor
    $out/bin/risor completion zsh > $out/share/zsh/site-functions/_risor
  '';

  meta = {
    homepage = "https://risor.io";
    license = lib.licenses.asl20;
    # maintainers = with lib.maintainers; [  ];
    description = "Fast and flexible scripting for Go developers and DevOps.";
  };
}
