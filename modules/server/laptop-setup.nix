{ config, pkgs, ... }:

{
  # Make the laptop ignore closing the lid
  services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "ignore";
  };
}

