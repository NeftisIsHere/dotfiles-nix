{ config, pkgs, ... }:

{
  # Make the laptop ignore closing the lid
  services.logind.extraConfig = ''
      HandleLidSwitch=ignore
      HandleLidSwitchDocked=ignore
      HandleLidSwitchExternalPower=ignore
  '';

  # Turns off the laptop screen
  systemd.services.turnOffScreen = {
    description = "Turn off laptop screen on boot";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.runtimeShell} -c 'echo 0 > /sys/class/backlight/intel_backlight/brightness || true'";
    };
  };
}

