{ pkgs, ... }: {
  home.packages = with pkgs; [
    vault
    pulumi-bin
    pulumictl
    terragrunt
    truss-cli
  ];

  home.shellAliases = {
    tf = "terraform";
  };

  programs.zsh.zplug = {
    plugins = [{
      name = "cda0/zsh-tfenv";
    }];
  };

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-terraform-completion
      { plugin = vim-terraform;
        config = ''
          let g:terraform_fmt_on_save = 1
        '';
      }
    ];
  };

}
