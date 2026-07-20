{
  pkgs,
  lib,
  ...
}: let
  yzx-refresh = pkgs.writeShellApplication {
    name = "yzx-refresh";
    runtimeInputs = with pkgs; [
      nix
      bash
    ];
    text = ''
      exec nix run --refresh github:luccahuguet/yazelix#yazelix -- "$@"
    '';
  };
in {
  users.users.karixos.packages = lib.filter (p: p != null) [
    pkgs.nh
    pkgs.nix-output-monitor
    pkgs.nvd
    pkgs.nix-tree
    pkgs.nix-diff
    pkgs.nix-index
    pkgs.nushell
    yzx-refresh
  ];

  environment.shellAliases = {
    ncg = "nh clean all --keep-since 14d --keep 10";
    nfu = "nix flake update";
  };
}
