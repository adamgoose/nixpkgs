{...}: {
  programs.zsh = {
    oh-my-zsh.plugins = [
      "terraform"
    ];
    zplug.plugins = [
      {
        name = "cda0/zsh-tfenv";
      }
    ];
  };
}
