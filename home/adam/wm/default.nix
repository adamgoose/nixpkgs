{ pkgs, ... }: {

  home.file.".config/sketchybar/".recursive = true;
  home.file.".config/sketchybar/".source = ./sketchybar;

  home.file.".config/sketchybar/plugins/Dynamic-Island-Sketchybar/".recursive = true;
  home.file.".config/sketchybar/plugins/Dynamic-Island-Sketchybar/".source = pkgs.fetchFromGitHub {
    owner = "crissNb";
    repo = "Dynamic-Island-Sketchybar";
    rev = "772ef47";
    sha256 = "sha256-3kJJrAfxRJk4UWPWBGqBl2t0Ljzn7vAuLejddTC3GMY=";
  };

}
