{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts.localhost = {
      listen = [
        { addr = "0.0.0.0"; port = 8080; }
      ];

      root = "/var/www/valentine";

      locations."/" = {
        tryFiles = "$uri $uri/ /index.html";
      };
    };
  };
}

