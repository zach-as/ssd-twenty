{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Install arion to manage docker containers
    arion
    # Install docker-client to talk to podman
    docker-client

    docker-compose
  ];

  # Arion works with docker, but for NixOS-based containers we need to use Podman
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;

  # Add permission to zacharyas
  users.extraUsers.zacharyas.extraGroups = [ "podman" ];
}
