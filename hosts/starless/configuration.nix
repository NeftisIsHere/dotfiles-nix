# Configuration for laptop being used as a shitty server lol
# CPU: Intel(R) Celeron(R) N3050 (2) @ 2.16 GHz
# GPU: Intel Atom/Celeron/Pentium Processor x5-E8000/J3xxx/N3xxx Integrated Graphics Controller @ 0.60 GHz [Integrated]
# RAM: 4GB

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/server
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "starless";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Santiago";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb.layout = "latam";

  users.users.jazz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
      fastfetch
      unzip
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    vim
    neovim
    fastfetch
    stow
    wget
    eza
    btop
    htop

    yazi.override {
      _7zz = _7zz-rar;
    })
    p7zip-rar
    chafa
    fd
    ffmpeg
    imagemagick
    jq
    poppler
    resvg
    ripgrep
    wl-clipboard
    zoxide

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
  ];


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

