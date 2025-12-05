{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    niri.url = "github:sodiboo/niri-flake";
    # Home manager stuffs
    # home-manager = { 
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in

  {
    nixosConfigurations = {
      fraKctured = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/fraKctured/configuration.nix
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.niri.nixosModules.niri
          # inputs.home-manager.nixosModules.default
          # {
          #   home-manager = {
          #     useGlobalPkgs = true;
          #     useUserPackages = true;
          #     users.jazz = import ./fraKctured/home;
          #     extraSpecialArgs = {
          #       inherit inputs;
          #     };
          #   };
          # }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      starless = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/starless/configuration.nix
          inputs.nix-flatpak.nixosModules.nix-flatpak
          # inputs.home-manager.nixosModules.default
          # {
          #   home-manager = {
          #     useGlobalPkgs = true;
          #     useUserPackages = true;
          #     users.jazz = import ./starless/home;
          #     extraSpecialArgs = {
          #       inherit inputs;
          #     };
          #   };
          # }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
