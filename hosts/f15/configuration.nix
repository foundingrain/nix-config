# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # ./modules/ai.nix
    ../../modules/corepackages.nix
    ../../modules/cosmic.nix
    # ../../modules/weylus.nix
    ../../modules/extra.nix
    ../../modules/gaming.nix
    # ../../modules/gnome.nix
    ../../modules/niri.nix
    # ../../modules/plasma.nix
    # ../../modules/hyprland.nix
    ../../modules/mullvad.nix
    # ../../modules/rdp.nix
    # ../../modules/school.nix
    ../../modules/sdr.nix
    ../../modules/social.nix
    ../../modules/tailscale.nix
    ../../modules/vm.nix

    # ../../modules/lineage.nix

    ../../modules/exclude.nix
  ];

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.nh.enable = true;

  # flatpak
  services.flatpak.enable = true;

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.limine.enable = true;
  /*
    boot.loader.limine.style.wallpapers = [
      ./IMG_9873.PNG
    ];
  */
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "breeze";
    # logo = ./GH-Neo-static.png;
  };

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  networking.hostName = "f15"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  /*
     # Enable Hyprland
     programs.hyprland = {
       enable = true;
       xwayland.enable = true;
     };

     # Enable polkit for Hyprland
    # security.polkit.enable = true;

     # Systemd service for kde-polkit
     systemd = {
       user.services.polkit-gnome-authentication-agent-1 = {
         description = "polkit-gnome-authentication-agent-1";
         wantedBy = [ "graphical-session.target" ];
         wants = [ "graphical-session.target" ];
         after = [ "graphical-session.target" ];
         serviceConfig = {
           Type = "simple";
           ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
           Restart = "on-failure";
           RestartSec = 1;
           TimeoutStopSec = 10;
         };
       };
     };
  */

  # Enable GNOME Theme for QT Applications.
  # qt = {
  #   enable = true;
  #   platformTheme = "qt5ct";
  #  style = "adwaita-dark";
  # };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  # Enable Avahi to autodiscover printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Enable SANE scanner support.
  hardware.sane.enable = true;
  #hardware.sane.extraBackends = [ pkgs.epkowa ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stimkyyy = {
    isNormalUser = true;
    description = "stimkyyy";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
      "scanner"
      "lp"
      "input"
    ];
    packages = with pkgs; [
      #nvtopPackages.nvidia
      bibata-cursors
      #ventoy-full
      protonvpn-gui
      ruffle
      # lightspark
      # python3
      gcc
      valgrind
      #jetbrains.idea-ultimate
      scribus
      # CaC
      #opensc
      #ccid
      #pcsctools
      # KDE
      kdePackages.kdenlive
      # korganizer
      # libsForQt5.kservice # Will be depreciated!!
      # Hyprland
      #mako
      #gammastep
      # hyprland-qtutils
      # wl-gammarelay-rs
      # hyprcursor
      #  lxappearance
      #  nwg-look
      #  qt5ct
      #  qt6ct
      # hyprlock
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    nwg-look
    # cudaPackages.cudatoolkit
    #flk-zen-browser
    #  pkgs.jellyfin
    #  pkgs.jellyfin-web
    #  pkgs.jellyfin-ffmpeg
    # Flakes
  ];

  # Disable hardware cursors
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = "1";
  };

  #Qt5 Config
  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Declare Xserver video driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable nvidia driver and AMD vulkan
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # NVIDIA
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # Optimus PRIME
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:0:2";
      nvidiaBusId = "PCI:0:1:0";
    };
  };

  # Jellyfin
  # services.jellyfin.enable = true;
  # services.jellyfin.openFirewall = true;
  # services.jellyfin.user = "stimkyyy";

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    #nerdfonts
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  # CaC
  #services.pcscd.enable = true;

  # Thunar and services
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # RGB control
  # services.hardware.openrgb.enable = true;
}
