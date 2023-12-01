{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib testers buildGoModule fetchFromGitHub;
in
{

  kubeswitch = buildGoModule rec {
    pname = "kubeswitch";
    version = "0.8.0";

    src = fetchFromGitHub {
      owner = "danielfoehrKn";
      repo = pname;
      rev = version;
      sha256 = "sha256-7BQhkFvOgmLuzBEvAou8KANhxWna5KVokIF4DEIVU2g=";
    };

    vendorHash = null;

    subPackages = [ "cmd/main.go" ];

    ldflags = [
      "-s"
      "-w"
      "-X github.com/danielfoehrkn/kubeswitch/cmd/switcher.version=${version}"
      "-X github.com/danielfoehrkn/kubeswitch/cmd/switcher.buildDate=1970-01-01"
    ];

    postInstall = ''
      mkdir -p $out/lib
      cp ${src}/hack/switch/switch.sh $out/lib/switch.sh
      mv $out/bin/main $out/bin/switcher
    '';

    meta = with lib; {
      description = "The kubectx for operators";
      license = licenses.asl20;
      homepage = "https://github.com/danielfoehrKn/kubeswitch";
      maintainers = with maintainers; [ bryanasdev000 ];
    };
  };

}
