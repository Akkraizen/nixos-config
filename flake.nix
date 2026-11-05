{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    serpantinum = {
      url = "github:ilyamiro/serpantinum";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, serpantinum, ... }:
    let
      mkHost = hostModule: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit serpantinum; };
        modules = [
          hostModule
          ./common.nix
          ./desktop.nix
          serpantinum.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit serpantinum; };
            home-manager.users.akkraizen = import ./home.nix;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        nixos = mkHost ./configuration.nix;   # ПК рядом с Windows
        laptop = mkHost ./laptop.nix;         # ноутбук, только NixOS
      };
    };
}