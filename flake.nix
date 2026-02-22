{
  description = "My NixOS configuration";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # pinned specific version of kubectl 1.35.0
    # https://www.nixhub.io/packages/kubectl
    kubectl.url = "github:nixos/nixpkgs/a1bab9e494f5f4939442a57a58d0449a109593fe";

    # terrafrom 1.14.5
    terraform.url = "github:nixos/nixpkgs/7d2ae6d8b8b697b5114a4249d0d958ee5f23d8fe";

    # fix vscode remote ssh server issue
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      vscode-server,
      kubectl,
      terraform,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      pinnedPackages = {

        kubectl = (import kubectl { inherit system; }).kubectl;

        terraform =
          (import terraform {
            inherit system;
            config.allowUnfree = true;
          }).terraform;

      };

    in
    {

      devShells.${system} = rec {
        ops = import ./hosts/shell.nix { inherit pkgs; };
        default = ops;
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

        inherit system;

        specialArgs = { inherit pinnedPackages; };

        modules = [
          ./modules/common.nix
          ./hosts/configuration.nix
          ./hosts/hardware-configuration.nix
          ./modules/services/ntp.nix
          ./modules/services/sshd.nix

          vscode-server.nixosModules.default
          (
            { config, pkgs, ... }:
            {
              services.vscode-server.enable = true;
            }
          )

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.yilgo = (import ./users/yilgo/nixos.nix);

          }

        ];
      };
    };
}
