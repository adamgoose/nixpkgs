{ inputs, cell }:
let

in
{

  astronvim = stdenv.mkDerivation {
    pname = "astronvim";
    version = "0.0.1";

    src = inputs.self + "/nix/home-manager/homeModules/ide/astrovim";

    buildInputs = [ neovim makeWrapper ];

    phases = [ "unpackPhase" "installPhase" ];

    installPhase = ''
      # Installation directory for the config
      mkdir -p $out/share/nvim
      cp -r $src/* $out/share/nvim

      # Wrapping the neovim executable to use the custom config directory
      makeWrapper ${neovim}/bin/nvim $out/bin/astronvim \
        --add-flags "-u $out/share/nvim/init.lua" \
        --set NVIM_CONFIG_HOME "$out/share/nvim"
    '';

    meta = with lib; {
      description = "A neovim wrapper that uses the AstroNvim configuration";
      homepage = "https://github.com/adamgoose/nixpkgs";
      license = licenses.mit;
      platforms = platforms.unix;
    };
  };

}
