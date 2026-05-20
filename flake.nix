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

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kickstart-nixvim.url = "github:JMartJonesy/kickstart.nixvim";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";

    boot-assets = {
      url = "git+ssh://git@github.com/foundingrain/private-boot-assets.git";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-index-database,
      zen-browser,
      boot-assets,
      ...
    }:
    let
      commonModules = [
        ./modules/nix.nix
        ./modules/flatpak.nix

        ./modules/boot.nix
        ./modules/corepackages.nix
        ./modules/development.nix
        ./modules/distrobox.nix
        ./modules/extra.nix
        ./modules/fonts.nix
        ./modules/gaming.nix
        ./modules/keychron.nix
        ./modules/mullvad.nix
        ./modules/printers.nix
        ./modules/sdr.nix
        ./modules/social.nix
        ./modules/sunshine.nix
        ./modules/syncthing.nix
        ./modules/tailscale.nix
        ./modules/vm.nix

        ./modules/exclude.nix # for build failures
      ];

      desktopModules = [
        ./modules/gnome.nix
        ./modules/niri.nix
        ./modules/mango.nix
        ./modules/noctalia.nix
      ];

      mkHost =
        {
          hostName,
          hmUser,
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hmUser; };

          modules = [
            { networking.hostName = hostName; }

            ./hosts/${hostName}
            {
              my.boot.imageDir = boot-assets;
            }

            nix-index-database.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = { inherit inputs hmUser; };

              home-manager.users.${hmUser} = {
                imports = [
                  ./home.nix
                  inputs.kickstart-nixvim.homeManagerModules.default
                  nix-index-database.homeModules.default
                  zen-browser.homeModules.beta
                ];

                programs.command-not-found.enable = false;
                programs.nixvim.enable = true;
                programs.nix-index.enable = true;
                programs.zen-browser.enable = true;
              };
            }
          ]
          ++ commonModules
          ++ desktopModules;
        };
    in
    {
      nixosConfigurations = {
        mashnix = mkHost {
          hostName = "mashnix";
          hmUser = "neo";
        };
        f15 = mkHost {
          hostName = "f15";
          hmUser = "stimkyyy";
        };
        thonknix = mkHost {
          hostName = "thonknix";
          hmUser = "neo";
        };
        vbox = mkHost {
          hostName = "vbox";
          hmUser = "neo";
        };
      };
    };
}
