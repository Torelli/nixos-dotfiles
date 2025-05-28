{
  description = "My NixOS config";

  outputs =
    inputs @ { nixpkgs
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
            ./hosts/vm.nix
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
                extraSpecialArgs = { inherit inputs username system; };
              };
            }
          ];
        };
      };
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    transparent-nvim = {
      url = "github:xiyaowong/transparent.nvim";
      flake = false;
    };
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
}
