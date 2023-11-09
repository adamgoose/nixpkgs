{ pkgs, ... }: {
  home.packages = with pkgs; [
    pass
    awscli2
    aws-vault
  ];

  home.sessionVariables = {
    AWS_VAULT_BACKEND = "pass";
    AWS_VAULT_PASS_PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
    PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "aws"
  ];
}
