{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./extra-drive.nix
      ../../modules/desktop/gnome/gnome-polkit.nix
    ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # niri-flake.cache.enable = false;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    plymouth.enable = true;
  };

  networking = {
    hostName = "fraKctured";
    networkmanager.enable = true;
  };
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

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Disable the X11 windowing system.
  services.xserver.enable = false;
  services.tuned.enable = true;
  services.power-profiles-daemon.enable = false;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  users.users.jazz = {
    isNormalUser = true;
    description = "Jazmin Irene Vallejos Cartes";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
      foot
    ];
  };
  programs.firefox = {
    enable = true;
  };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  programs.starship.enable = true;

  # Trying to enable ssh agent
  programs.ssh.startAgent = false;
  services.gnome.gcr-ssh-agent.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.seahorse.enable = true;

  # Gaming
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = false;
  programs.gamemode.enable = true;


  services.mpd = {
    enable = true;
    user = "jazz";
    musicDirectory = "/home/jazz/Music";
    playlistDirectory = "/home/jazz/Documents/Playlists";
    # network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true;
    extraConfig = ''
      restore_paused "yes"
      max_output_buffer_size "16384"
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
      audio_output {
        type    "fifo"
        name    "my_fifo"
        path    "/tmp/mpd.fifo"
        format  "44100:16:2"
      }
    '';
  };
  systemd.services.mpd.environment = {
   XDG_RUNTIME_DIR = "/run/user/1001/";
  };

  environment.systemPackages = with pkgs; [
    # dev
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

    (chromium.override {
      commandLineArgs = [
        "--enable-features=AcceleratedVideoEncoder"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
      ];
    })

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
    wtype
    cliphist
    xwayland-satellite
    brightnessctl
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

  # List services that you want to enable:
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "launcher.moe";
        location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
      }
    ];
    packages = [
      # "com.obsproject.Studio"
      "com.saivert.pwvucontrol"
      "com.vysp3r.ProtonPlus"
      "net.waterfox.waterfox"
      { appId = "moe.launcher.the-honkers-railway-launcher"; origin = "launcher.moe"; }
    ];
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  system.stateVersion = "25.05";

}

