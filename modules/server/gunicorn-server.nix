{ config, pkgs, ... }:

let
  pythonEnv = pkgs.python312.withPackages (p: [
    p.django
    p.gunicorn
  ]);
in
{
  environment.systemPackages = [ pythonEnv ];

  systemd.services.fitcloud-gunicorn = {
    description = "FitCloud Django App (Gunicorn)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "jazz";
      Group = "users";
      WorkingDirectory = "/home/jazz/FitCloud/fitcloud";
      ExecStart = "${pythonEnv}/bin/gunicorn fitcloud.wsgi:application --bind 0.0.0.0:8000 --workers 3";
      Restart = "always";
      RestartSec = 3;
    };
  };
}


