{ lib, stdenv, fetchzip, jdk, gradle, makeWrapper, maven }:

stdenv.mkDerivation rec {
  pname = "kotlin-language-server";
  version = "1.3.2";
  src = fetchzip {
    url = "https://github.com/adamgoose/kotlin-language-server/releases/download/${version}/server.zip";
    sha256 = "sha256-ffM2kKtszoGelca+UERmko/ZUlABucFAXIaS8FPgA7s=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -r lib/* $out/lib
    cp -r bin/* $out/bin
  '';

  nativeBuildInputs = [ gradle makeWrapper ];
  buildInputs = [ jdk gradle ];

  postFixup = ''
    wrapProgram "$out/bin/kotlin-language-server" --set JAVA_HOME ${jdk} --prefix PATH : ${lib.strings.makeBinPath [ jdk maven ] }
  '';

  meta = {
    description = "kotlin language server";
    longDescription = ''
      About Kotlin code completion, linting and more for any editor/IDE
      using the Language Server Protocol Topics'';
    maintainers = with lib.maintainers; [ vtuan10 ];
    homepage = "https://github.com/fwcd/kotlin-language-server";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
