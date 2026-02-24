{
  description = "Multi-host NixOS configuration";

  nixConfig = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://niri.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z8eK0FlhTr8JQh0Qs="
    ];
  };

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

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, niri-flake, dms, ... }:
  let
    mkHost = { hostName, system, modules, enableGui ? false }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hostName enableGui niri-flake dms; };
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
