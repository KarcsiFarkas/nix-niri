{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  herdrPkg =
    if (inputs ? herdr && inputs.herdr.packages ? ${system})
    then inputs.herdr.packages.${system}.default
    else (pkgs.herdr or pkgs.tmux);
in {
  users.users.karixos.packages = [
    herdrPkg
  ];
}
