{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    assets.url = "git+https://github.com/randomScanian/assets-for-nixos-configs?submodules=1";
    assets.flake = false;

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = ["aarch64-linux" "x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    nur-no-pkgs-nixos = import inputs.nur {
      pkgs = null;
      nurpkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    };

    mkSys = hostname: system: isgui: timezone: loc1: loc2:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./modules/nixos/default.nix
          ./hosts/${hostname}/nixos/default.nix
          {
            networking.hostName = hostname;
            time.timeZone = timezone;
            i18n.defaultLocale = loc1;
            i18n.extraLocaleSettings = {
              LC_ADDRESS = loc2;
              LC_IDENTIFICATION = loc2;
              LC_MEASUREMENT = loc2;
              LC_MONETARY = loc2;
              LC_NAME = loc2;
              LC_NUMERIC = loc2;
              LC_PAPER = loc2;
              LC_TELEPHONE = loc2;
              LC_TIME = loc2;
            };
            environment.systemPackages = with inputs.nixpkgs.legacyPackages.${system}.pkgs; [
              firefox
              alacritty
              gnupg
              git
            ];
          }
          inputs.nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.sharedModules = [inputs.nur.hmModules.nur ./modules/home-manager/default.nix];
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
          }
        ];
      };
  in {
    packages =
      forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      Abydos =
        mkSys "Abydos" "x86_64-linux" true "Europe/Stockholm" "en_US.UTF-8"
        "sv_SE.UTF-8";
    };
  };
}
