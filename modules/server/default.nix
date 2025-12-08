{ config, lib, ...}:

{
  imports = [
    ./gunicorn-server.nix
    ./laptop-setup.nix
  ];
  # Activates rootless docker
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  
}
