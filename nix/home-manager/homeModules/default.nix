{ inputs, cell }: {

  aws = import ./aws;
  charm = import ./charm;
  cli = import ./cli;
  hyprland = import ./hyprland;
  iac = import ./iac;
  ide = import ./ide;
  ide-full = import ./ide-full;
  k8s = import ./k8s;
  raycast = import ./raycast;
  syncthing = import ./syncthing;
  wm = import ./wm;

}
