{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";
    home = "${self}/home";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    legion = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ laptop
        ++ [
          ./legion
          "${mod}/services/gnome-services.nix"
          "${mod}/core/limine.nix"
          "${home}"

          inputs.agenix.nixosModules.default
        ];
    };

    wsl-host = nixosSystem {
      inherit specialArgs;
      modules = [
        ./wsl-host

        "${mod}/nix"
        "${mod}/programs/fish.nix"

        inputs.agenix.nixosModules.default
        inputs.nixos-wsl.nixosModules.default
      ];
    };
  };
}
