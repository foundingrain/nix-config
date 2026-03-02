{
  description = "Monolithic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    kickstart-nixvim.url = "github:JMartJonesy/kickstart.nixvim";
    waybar-niri-workspaces-enhanced.url = "github:justbuchanan/waybar-niri-workspaces-enhanced";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-index-database,
      waybar-niri-workspaces-enhanced,
      zen-browser,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };

          modules = [
            { networking.hostName = hostName; }

            ./hosts/${hostName}/configuration.nix
            # ./hosts/${hostName}/hardware-configuration.nix

            nix-index-database.nixosModules.default

            home-manager.nixosModules.home-manager
            (
              { config, ... }:
              let
                hmUser = if config.networking.hostName == "f15" then "stimkyyy" else "neo";
              in
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "hm-bak";

                # Pass username to HM
                home-manager.extraSpecialArgs = { inherit inputs hmUser; };

                home-manager.users.${hmUser} = {
                  imports = [
                    ./home.nix
                    inputs.kickstart-nixvim.homeManagerModules.default
                    nix-index-database.homeModules.default
                    waybar-niri-workspaces-enhanced.homeModules.default
                    zen-browser.homeModules.beta
                  ];

                  programs.command-not-found.enable = false;
                  programs.nixvim.enable = true;
                  programs.nix-index.enable = true;
                  programs.waybar.niri-workspaces-enhanced.enable = true;
                  programs.zen-browser.enable = true;
                };
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        mashnix = mkHost { hostName = "mashnix"; };
        f15 = mkHost { hostName = "f15"; };
        thonknix = mkHost { hostName = "thonknix"; };
      };
    };
}
