{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib buildGoModule fetchFromGitHub;
in
{

  hasura-cli = buildGoModule rec {
    pname = "hasura-cli";
    version = "2.18.0";

    src = fetchFromGitHub {
      owner = "hasura";
      repo = "graphql-engine";
      rev = "v${version}";
      sha256 = "sha256-Iy7uLXfKEzh1uZ1MimiY5lrl4GqWeK/nlfeMgWtg1+0=";
    };
    modRoot = "./cli";

    subPackages = [ "cmd/hasura" ];

    vendorHash = "sha256-vZKPVQ/FTHnEBsRI5jOT6qm7noGuGukWpmrF8fK0Mgs=";

    doCheck = false;

    ldflags = [
      "-X github.com/hasura/graphql-engine/cli/v2/version.BuildVersion=${version}"
      "-s"
      "-w"
    ];

    postInstall = ''
      mkdir -p $out/share/{bash-completion/completions,zsh/site-functions}
      export HOME=$PWD
      $out/bin/hasura completion bash > $out/share/bash-completion/completions/hasura
      $out/bin/hasura completion zsh > $out/share/zsh/site-functions/_hasura
    '';

    meta = {
      homepage = "https://www.hasura.io";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ lassulus ];
      description = "Hasura GraphQL Engine CLI";
    };
  };

}
