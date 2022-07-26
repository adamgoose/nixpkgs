{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "tere";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "mgunyho";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-BD7onBkFyo/JAw/neqL9N9nBYSxoMrmaG6egeznV9Xs=";
  };

  cargoSha256 = "sha256-gAq9ULQ2YFPmn4IsHaYrC0L7NqbPUWqXSb45ZjlMXEs=";

  doCheck = false;

  meta = with lib; {
    description = "Terminal file explorer";
    homepage = "https://github.com/mgunyho/tere";
    # license = with licenses; [ mit /* or */ asl20 ];
    # maintainers = with maintainers; [ figsoda ];
  };
}
