{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    systems.url = "github:nix-systems/default";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.zig_0_10
          ];
        };
      };
    };
}
