{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };
      "*.tsh.bridgeops.sh tsh.bridgeops.sh" = {
        identityFile = "/Users/adam/.tsh/keys/tsh.bridgeops.sh/adamgoose";
        certificateFile = "/Users/adam/.tsh/keys/tsh.bridgeops.sh/adamgoose-ssh/tsh.bridgeops.sh-crt.pub";
        extraOptions = {
          UserKnownHostsFile = "/Users/adam/.tsh/known_hosts";
        };
      };
      "*.tsh.bridgeops.sh !tsh.bridgeops.sh" = {
        port = 3022;
        proxyCommand = "tsh config-proxy --login=\"%r\" --proxy=tsh.bridgeop.sh:3023 %h:%p tsh.bridgeops.sh";
      };
      "github.com" = {
        identityFile = "/Users/adam/.ssh/id_rsa";
      };
    };
  };

  home.shellAliases = {
    truss = "truss-cli";
    ave = "aws-vault exec --mfa-token $(op item get \"Amazon Bridge-Users\" --otp)";
    avl = "aws-vault login --mfa-token $(op item get \"Amazon Bridge-Users\" --otp)";
  };
}
