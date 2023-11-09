{ inputs, cell }: {

  aws = import ./aws;
  cli = import ./cli;
  hyprland = import ./hyprland;
  iac = import ./iac;
  ide = import ./ide;
  ide-full = import ./ide-full;
  k8s = import ./k8s;
  syncthing = import ./syncthing;
  wm = import ./wm;

}
