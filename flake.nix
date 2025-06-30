{
  description = "My NixOS config";

  outputs =
    inputs @ { nixpkgs
    , nixpkgs-stable
    , home-manager
    , ...
    }:
    let
      username = "torelli";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        "torelli-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs username system;
          };
          modules = [
            ./hosts/laptop.nix
            {
              nix.settings.trusted-users = [ "torelli" ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "old";
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.torelli = import ./home-manager/home.nix;
                extraSpecialArgs = {
                  inherit inputs username system;
                  pkgs-stable = import nixpkgs-stable {
                    inherit inputs username system;
                    config.allowUnfree = true;
                  };
                };
              };
            }
          ];
        };
      };
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };
    matugen.url = "github:InioX/Matugen?rev=0bd628f263b1d97f238849315f2ce3ab4439784e";
  };
}
