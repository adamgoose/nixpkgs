# { buildGoModule, fetchFromGitHub, ... }:

{ inputs, cell }:
let
  inherit (inputs.nixpkgs) buildGoModule fetchFromGitHub;
in
{

  kubetap = buildGoModule rec {
    pname = "kubetap";
    version = "0.1.4";

    src = fetchFromGitHub {
      owner = "soluble-ai";
      repo = "kubetap";
      rev = "v${version}";
      sha256 = "sha256-Ba6scRhQN6CeOTU8QEnniZ1p/IFLS/STCxne96aKX9o=";
    };

    vendorSha256 = "sha256-oR4pV32q7kiAxK+fqjxhBqQTfcfxY/JgEBVepQWToF4=";
    subPackages = [ "cmd/kubectl-tap" ];
  };

}
