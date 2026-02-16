{
  description = "Multi-host NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, niri-flake, ... }:
  let
    mkHost = { hostName, system, modules, enableGui ? false }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hostName enableGui niri-flake; };
        modules = [
          home-manager.nixosModules.home-manager
        ] ++ modules;
      };
  in {
    nixosConfigurations = {
      wsl = mkHost {
        hostName = "wsl";
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/wsl
        ];
      };

      laptop = mkHost {
        hostName = "laptop";
        system = "x86_64-linux";
        enableGui = true;
        modules = [
          niri-flake.nixosModules.niri
          ./hosts/laptop
        ];
      };

      vm-fusion = mkHost {
        hostName = "vm-fusion";
        system = "aarch64-linux";
        enableGui = true;
        modules = [
          niri-flake.nixosModules.niri
          ./hosts/vm-fusion
        ];
      };
    };
  };
}
