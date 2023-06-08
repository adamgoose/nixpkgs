{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "truss-cli";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "get-bridge";
    repo = "truss-cli";
    rev = "v${version}";
    sha256 = "sha256-GNs+CGcXcoImYQM3mMfwuATUn4A0gziy7DKtF08krb8=";
  };
  vendorSha256 = "sha256-9hV4gh6RHsPff9XsFyVybMc5QSe54ZPZjIrPL+HFVBs=";

  doCheck = false;

  nativeBuildInputs = [ installShellFiles ];
  ldflags = [ "-s -w -X github.com/get-bridge/truss-cli/cmd.Version=${version}" ];

  postInstall = ''
    mv $out/bin/truss-cli $out/bin/truss
    installShellCompletion --cmd truss \
      --bash <($out/bin/truss completion bash) \
      --fish <($out/bin/truss completion fish) \
      --zsh <($out/bin/truss completion zsh)
  '';

  meta = with lib; {
    homepage = "https://github.com/get-bridge/truss-cli";
    description = "CLI to help you manage many k8s clusters";
    platforms = platforms.linux ++ platforms.darwin;
    license = licenses.mit;
    # maintainers = [ (import ../../../../maintainers/maintainer-list.nix).craun ];
  };
}
