{pkgs, ...}: {
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
      import catppuccin
      catppuccin.setup(c, 'macchiato', False)
    '';
    settings = {
      fonts = {
        default_family = "FiraCode Nerd Font";
        default_size = "16pt";
      };
      colors.webpage.darkmode = {
        enabled = true;
        policy.images = "never";
      };
      content.tls.certificate_errors = "ask-block-thirdparty";
      auto_save.session = true;
    };
    keyBindings = {
      normal = {
        ",p" = "spawn --userscript qute-1password";
      };
    };
  };

  home.file.".config/qutebrowser/catppuccin" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "qutebrowser";
      rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
      sha256 = "sha256-lp7HWYuD4aUyX1nRipldEojZVIvQmsxjYATdyHWph0g=";
    };
  };

  home.file.".config/qutebrowser/userscripts/qute-1password" = {
    source = pkgs.fetchurl {
      url = "https://github.com/applejag/qutebrowser/raw/feature/userscript-1pass-op-v2/misc/userscripts/qute-1pass";
      sha256 = "sha256-CwFTZwg4GdwcjcK5tBhcrcAIG9FP7nqxUEvJII0b5Eg=";
    };
    executable = true;
  };
}
