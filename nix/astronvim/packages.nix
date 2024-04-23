{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib stdenv neovim makeWrapper;
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
      mkdir -p $out/share/astronvim
      cp -r $src/* $out/share/astronvim

      # Wrapping the neovim executable to use the custom config directory
      makeWrapper ${neovim}/bin/nvim $out/bin/astronvim \
        --add-flags "-u $out/share/astronvim/init.lua" \
        --set XDG_CONFIG_HOME "$out/share" \
        --set NVIM_APPNAME astronvim
    '';

    meta = with lib; {
      description = "A neovim wrapper that uses the AstroNvim configuration";
      homepage = "https://github.com/adamgoose/nixpkgs";
      license = licenses.mit;
      platforms = platforms.unix;
    };
  };

}
