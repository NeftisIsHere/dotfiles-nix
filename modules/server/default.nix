{ config, lib, ...}:

{
  imports = [
    ./laptop-setup.nix
    ./mysql.nix
    ./nginx.nix
  ];
  # Activates rootless docker
  virtualisation.docker.rootless = {
    enable = true;
  };
  
}
