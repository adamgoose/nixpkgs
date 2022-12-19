{ stdenv, buildYarnPackage, fetchFromGitHub, ... }:

buildYarnPackage {
  pname = "coc-volar";
  version = "0.25.15";
  src = fetchFromGitHub {
    owner = "yaegassy";
    repo = "coc-volar";
    rev = "e32a84197d3a9a7c061e44930a292765999f31ab";
    sha256 = "sha256-7bgZwhrTjUbDG83le2vfBAqsDzs4k5/bOG4A3Zoyd4o=";
  };
}
