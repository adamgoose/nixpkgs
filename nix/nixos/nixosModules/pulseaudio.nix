{username, ...}: {
  hardware.pulseaudio.enable = true;
  users.users.${username}.extraGroups = ["audio"];
}
