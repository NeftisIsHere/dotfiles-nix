{ config, pkgs, lib, ... }:

{
  security.polkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent = {
    enable = true;
    description = "GNOME Polkit Authentication Agent";
    serviceConfig = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };
}

