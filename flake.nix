{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      arion,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inherit (self) outputs;

    in
    rec {
      envModule = import ./modules/env.nix;
      scriptsModule = (import ./modules/scripts.nix) {
        inherit pkgs;
        inherit outputs;
      };
      devShells.${system}.twenty = pkgs.mkShell {
        packages = with pkgs; [
          postgresql_16
          redis
          #envModule
          #scriptsModule
          nodejs_24
        ];
        specialArgs = {
          inherit inputs;
          inherit outputs;
          inherit arion;
        };
        modules = [
          (import /home/zacharyas/projects/twenty/arion/arion.nix)
          #  ./arion.nix
        ];
        buildInputs = [
          #envModule
          #scriptsModule
        ];
        shellHook = ''
          # init postgres db
          #init_default
          # Provision postgres db
          #make postgres-on-docker
          # Provision redis cache
          #make redis-on-docker
          # Install dependencies
          #yarn
          # Set up twenty db
          npx nx database:reset twenty-server
          # Start the server
          npx nx start twenty-server
          # Start the worker
          npx nx worker twenty-server
          # Start the frontend
          npx nx start twenty-front
        '';
      };
    };
}
