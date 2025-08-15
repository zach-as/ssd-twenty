{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    arion = {
      url = "github:nix-community/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      inputs,
      nixpkgs,
      arion,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inherit (self) outputs;

    in
    {
      envModule = import ./env.nix;
      devShells.${system}.twenty = pkgs.mkShell {
        packages = with pkgs; [
          docker-client
          docker-compose
          arion
          postgresql_16
          redis
        ];
        specialArgs = {
          inherit inputs;
          inherit outputs;
          inherit arion;
        };
        modules = [
          ./arion.nix
        ];
        shellHook = ''

        '';
      };
    };
}
