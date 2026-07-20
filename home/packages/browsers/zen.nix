{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  zenPkg =
    if (inputs ? zen-browser && inputs.zen-browser.packages ? ${system})
    then inputs.zen-browser.packages.${system}.default
    else (pkgs.zen-browser or pkgs.firefox);
in {
  users.users.karixos.packages = [zenPkg];
  environment.sessionVariables = {
    DEFAULT_BROWSER = "zen";
    BROWSER = "zen";
  };
}
