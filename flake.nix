{
  description = "Flake for mashnix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    kickstart-nixvim.url = "github:JMartJonesy/kickstart.nixvim";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-index-database,
      zen-browser,
      ...
    }:
    {
      nixosConfigurations.mashnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.neo = {
              imports = [
                ./home.nix
                inputs.kickstart-nixvim.homeManagerModules.default
                zen-browser.homeModules.beta
              ];
              programs.nixvim.enable = true;
              programs.zen-browser.enable = true;
            };
          }
        ];
      };
    };
}
