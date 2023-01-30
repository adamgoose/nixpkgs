{ pkgs, ... }: {
  home.packages = with pkgs; [
    pass
    awscli2
    aws-vault
  ];

  home.sessionVariables = {
    AWS_VAULT_BACKEND = "pass";
    # TODO: Use dynamic home directory, or better yet, xdg or whatever /.local/share
    AWS_VAULT_PASS_PASSWORD_STORE_DIR = "/Users/adam/.local/share/password-store";
    PASSWORD_STORE_DIR = "/Users/adam/.local/share/password-store";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "aws"
  ];
}
