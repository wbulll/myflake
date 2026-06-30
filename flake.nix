{
  description = "A very basic NixOS flake";

  inputs = {
    # Unstable (but now stable :p)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Stable (both are stable :p)
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    # Noctalia v5
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # Alejandra formatter
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations.oto = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      modules = [
        ./configuration.nix

        # Inline module for extra system packages or inputs
        ({pkgs, ...}: {
          environment.systemPackages = [
            # inputs.noctalia.packages.${system}.default
          ];
        })
      ];
    };
  };
}
