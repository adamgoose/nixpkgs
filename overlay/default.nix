# Your overlays go here (see https://nixos.wiki/wiki/Overlays)
{ devenv, ... }:
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

  kubetap = final.buildGoModule rec {
    pname = "kubetap";
    version = "0.1.4";

    src = final.fetchFromGitHub {
      owner = "soluble-ai";
      repo = "kubetap";
      rev = "v${version}";
      sha256 = "sha256-Ba6scRhQN6CeOTU8QEnniZ1p/IFLS/STCxne96aKX9o=";
    };

    vendorSha256 = "sha256-oR4pV32q7kiAxK+fqjxhBqQTfcfxY/JgEBVepQWToF4=";
    subPackages = [ "cmd/kubectl-tap" ];
  };

  kubeswitch = final.buildGoModule rec {
    pname = "kubeswitch";
    version = "0.7.2";

    src = final.fetchFromGitHub {
      owner = "danielfoehrKn";
      repo = pname;
      rev = version;
      sha256 = "sha256-p4/nYZt+OwNsFX9f9ySfQaz6gbz+8Mvt00W2Rs4dpCY=";
    };

    vendorSha256 = null;

    subPackages = [ "cmd/main.go" ];

    ldflags = [
      "-s" "-w"
      "-X github.com/danielfoehrkn/kubeswitch/cmd/switcher.version=${version}"
      "-X github.com/danielfoehrkn/kubeswitch/cmd/switcher.buildDate=1970-01-01"

    ];

    passthru.tests.version = final.testers.testVersion {
      package = final.kubeswitch;
    };

    postInstall = ''
      mkdir -p $out/lib
      cp ${src}/hack/switch/switch.sh $out/lib/switch.sh
      mv $out/bin/main $out/bin/switcher
    '';

    meta = with final.lib; {
      description = "The kubectx for operators";
      license = licenses.asl20;
      homepage = "https://github.com/danielfoehrKn/kubeswitch";
      maintainers = with maintainers; [ bryanasdev000 ];
    };
  };

  devenv = devenv.packages.${prev.system}.devenv;
} // import ../pkgs { pkgs = final; }
