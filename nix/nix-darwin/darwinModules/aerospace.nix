{
  lib,
  pkgs,
  unstable,
  ...
}: {
  services.aerospace = {
    enable = true;
    package = unstable.aerospace;
    settings = {
      accordion-padding = 90;
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      on-window-detected =
        [
          {
            "if".app-id = "com.mitchellh.ghostty";
            run = ["move-node-to-workspace 1"];
          }
          {
            "if".workspace = "1";
            run = ["move-node-to-workspace 2"];
            check-further-callbacks = true;
          }
          {
            "if".app-id = "com.raycast.macos";
            "if".window-title-regex-substring = "AI Chat";
            run = ["layout tiling"];
          }
        ]
        ++ lib.forEach [
          "com.apple.finder"
          "com.downstairsgeek.crc"
          "com.1password.1password"
          "com.mosyle.macos.business"
          "com.flexibits.fantastical2.mac"
          "com.cocoatech.PathFinder-setapp"
        ] (x: {
          "if".app-id = x;
          run = ["layout floating"];
        });

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 10;
        outer.bottom = 10;
        outer.top = 10;
        outer.right = 10;
      };
      workspace-to-monitor-force-assignment = {
        "9" = 2;
      };
      mode.main.binding = {
        alt-slash = "layout tiles accordion";
        alt-shift-slash = "layout horizontal vertical";
        alt-z = "fullscreen";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";

        alt-s = ["mode service"];
        alt-r = ["mode resize"];

        alt-cmd-space = "workspace --auto-back-and-forth 1";
      };
      mode.service.binding = {
        esc = ["mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];

        alt-h = ["join-with left" "mode main"];
        alt-j = ["join-with down" "mode main"];
        alt-k = ["join-with up" "mode main"];
        alt-l = ["join-with right" "mode main"];
      };
      mode.resize.binding = {
        esc = ["mode main"];

        alt-h = ["resize width -100"];
        alt-j = ["resize height -100"];
        alt-k = ["resize height +100"];
        alt-l = ["resize width +100"];
      };
    };
  };

  system.defaults = {
    dock.expose-group-apps = true;
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  };

  environment.systemPackages = with pkgs; [
    # autoraise
  ];
}
