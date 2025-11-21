# Configuration for laptop ASUS Vivobook pro 14
# CPU: Intel Core i5-1130H 11th Gen
# iGPU: Irix Xe Graphics
# GPU: GeForce GTX 1650 Mobile / Max-Q
# RAM: 8GB

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable Plymouth
  boot.plymouth.enable = true;

  boot.initrd.kernelModules = [
    "i915"
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  boot.kernelParams = [
    "rd.driver.blacklist=nouveau"
    "nvidia-drm.modeset=1"
    "loglevel=3"
    "quiet"
    "splash"
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "starless";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "America/Santiago";

  i18n = {
    defaultLocale = "es_CL.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
    };
  };
  console = {
    useXkbConfig = true;
  };
  # Enable the X11 windowing system.
  services.xserver.enable = false;
  
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "latam";
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jazz = {
    isNormalUser = true;
    description = "Jazmin Irene Vallejos Cartes";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.starship.enable = true;


  programs.steam.enable = true;
  programs.steam.package = pkgs.steam.override {
    extraArgs = "-system-composer";
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    tree
    foot
    vscode
    git
    gcc
    lua
    go
    cmake
    gnumake
    devenv


    statix
    deadnix
    nixfmt-rfc-style

    # GAMING
    mangohud
    lutris
    heroic
    gcc
    unzip

    # Minecraft
    prismlauncher
    javaPackages.compiler.temurin-bin.jre-17

    # For osu-winello
    zenity

    chromium

    mpv
    rmpc


    vim
    neovim
    fastfetch
    stow
    wget
    eza
    cmatrix
    cava
    cbonsai
    btop
    htop
    alacritty
    swww
    fuzzel
    bemoji
    xwayland-satellite
    waybar
    wayland-logout
    wlogout
    swaynotificationcenter
    #replace
    hyprlock
    swaylock
    #replace
    hypridle
    swayidle

    (yazi.override {
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

    legcord

    nicotine-plus

    qbittorrent

    piper
    libayatana-appindicator
  ];

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    font-awesome
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.noto
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.hack
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

}

