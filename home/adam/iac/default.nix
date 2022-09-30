{ pkgs, ... }: {
  home.packages = with pkgs; [
    vault
    tfswitch
    pulumi-bin
    pulumictl
    terragrunt
    truss-cli
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-terraform-completion
      { plugin = vim-terraform;
        config = ''
          g:terraform_fmt_on_save = 1
        '';
      }
    ];
  };
}
