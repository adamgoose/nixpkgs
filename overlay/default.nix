# Your overlays go here (see https://nixos.wiki/wiki/Overlays)
{ ... }:
final: prev: {

  nodePackages = prev.nodePackages // {
    coc-volar = final.callPackage ./coc-valor.nix {};
  };

  vimPlugins = prev.vimPlugins // {
    coc-volar = prev.vimUtils.buildVimPluginFrom2Nix {
      pname = "coc-volar";
      version = "0.25.15";
      src = "${final.nodePackages.coc-volar}";
    };
  };
} // import ../pkgs { pkgs = final; }
