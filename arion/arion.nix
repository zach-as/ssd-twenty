{
  arion,
  pkgs,
  ...
}:

{
  imports = [
    arion.nixModules.arion
  ];

  virtualisation.arion = {
    backend = "podman-socket";
    projects.twenty = {
      serviceName = "twenty";
      settings = {
        imports = [ ./arion-compose.nix ];
      };
    };
  };
}
