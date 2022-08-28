{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      asvetliakov.vscode-neovim
      # vscodevim.vim
      jnoortheen.nix-ide
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "platformio-ide";
        publisher = "platformio";
        version = "2.5.2";
        sha256 = "sha256-RWO47AVEarIpakkHGFXjtI0UOzCRBFFgPH6bAfOfXbk=";
      }
    ];

    userSettings = {
      "update.mode" = "none";
      "workbench.colorTheme" = "Nord";
      "vscode-neovim.neovimExecutablePaths.linux" = pkgs.neovim + "/bin/nvim";
      "platformio-ide.activateOnlyOnPlatformIOProject" = true;
      "platformio-ide.useBuiltinPython" = false;
      "platformio-ide.useBuiltinPIOCore" = false;
      "platformio-ide.pioHomeServerHttpPort" = 8008;
      "platformio-ide.pioHomeServerHttpHost" = "0.0.0.0";
    };
  };

}
