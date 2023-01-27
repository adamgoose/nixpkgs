{ lib, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };
      "*.tsh.bridgeops.sh tsh.bridgeops.sh" = lib.hm.dag.entryBefore ["*.tsh.bridgeops.sh !tsh.bridgeops.sh"] {
        identityFile = "/Users/adam/.tsh/keys/tsh.bridgeops.sh/adamgoose";
        certificateFile = "/Users/adam/.tsh/keys/tsh.bridgeops.sh/adamgoose-ssh/tsh.bridgeops.sh-cert.pub";
        extraOptions = {
          UserKnownHostsFile = "/Users/adam/.tsh/known_hosts";
        };
      };
      "*.tsh.bridgeops.sh !tsh.bridgeops.sh" = {
        port = 3022;
        proxyCommand = "tsh proxy ssh --cluster=tsh.bridgeops.sh --proxy=tsh.bridgeops.sh %r@%h:%p";
      };
      "github.com" = {
        identityFile = "/Users/adam/.ssh/id_rsa";
      };
    };
  };

  home.shellAliases = {
    ave = "aws-vault exec --mfa-token $(op item get \"Amazon Bridge-Users\" --otp) --duration 8h";
    avl = "aws-vault login --mfa-token $(op item get \"Amazon Bridge-Users\" --otp) --duration 8h";
  };
}
