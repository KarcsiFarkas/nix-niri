{
  pkgs,
  lib,
  ...
}: let
  bwssh = pkgs.writeShellApplication {
    name = "bwssh";
    runtimeInputs = with pkgs; [
      bitwarden-cli
      jq
      openssh
    ];
    text = ''
      if [ -z "''${BW_SESSION:-}" ]; then
        if [ -n "''${BW_MASTER_PASSWORD_FILE:-}" ] && [ -f "$BW_MASTER_PASSWORD_FILE" ]; then
          export BW_SESSION="$(bw unlock --raw --passwordfile "$BW_MASTER_PASSWORD_FILE")"
        else
          echo "BW_SESSION environment variable is not set and no master password file available." >&2
          exit 1
        fi
      fi
      exec bw "$@"
    '';
  };
in {
  users.users.karixos.packages = with pkgs; [
    age
    sops
    ssh-to-age
    pass
    bitwarden-cli
    _1password-cli
    bwssh
  ];

  environment.shellAliases = {
    sshbw = "bwssh";
    bws = "bwssh";
    bwssh-list = "bwssh list";
  };
}
