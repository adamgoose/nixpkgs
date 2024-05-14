{...}: {
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    dock.show-recents = false;
    dock.wvous-bl-corner = 4; # Desktop
    dock.wvous-br-corner = 2; # Mission Control
    dock.wvous-tr-corner = 5; # Start Screen Saver
    dock.wvous-tl-corner = 6; # Disable Screen Saver
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder._FXShowPosixPathInTitle = true;
    trackpad.Clicking = true;
    trackpad.Dragging = true;
    NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
  };

  security.pam.touchIdAuth.enable = true;
}
