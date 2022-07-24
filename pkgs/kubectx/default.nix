{ lib, buildGo118Module, fetchFromGitHub, installShellFiles }:

buildGo118Module rec {
  pname = "kubectx";
  version = "master";

  src = fetchFromGitHub {
    owner = "ahmetb";
    repo = pname;
    rev = "${version}";
    sha256 = "1cd5bs7gd75sy38y83dcajr36j0cmj56fi3dv5yi41cr39h2d16b";
  };

  vendorSha256 = "sha256-LYGv0hFZy4dV9qRXdxNur8CN3IS4bWp03+BCwO+YrYc=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion completion/*
  '';

  meta = with lib; {
    description = "Fast way to switch between clusters and namespaces in kubectl!";
    license = licenses.asl20;
    homepage = "https://github.com/ahmetb/kubectx";
    maintainers = with maintainers; [ jlesquembre ];
    platforms = with platforms; unix;
  };
}
