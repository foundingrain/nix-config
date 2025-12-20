{
  config,
  lib,
  pkgs,
  ...
}:
let
  isGnome = (config.services.xserver.desktopManager.gnome.enable or false);
  isPlasma = (config.services.xserver.desktopManager.plasma6.enable or false);
  isNiri = config.services.displayManager.defaultSession == "niri";

  polkitExec =
    if isGnome then
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    else if isPlasma then
      "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
    else
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
in
{
  environment.systemPackages = with pkgs; [
    alacritty
    blueman
    brightnessctl
    cliphist
    fuzzel
    kanshi
    networkmanagerapplet
    niriswitcher
    nwg-look
    pavucontrol
    sunsetr
    swww
    swaylock-effects
    swaylock-fancy
    swaynotificationcenter
    xwayland-satellite
    wlogout
  ];

  programs = {
    niri.enable = true;
  };

  services = {
    blueman.enable = lib.mkIf isNiri true;
  };

  # Install appropriate polkit
  systemd.user.services.polkit-auth-agent = {
    description = "Polkit authentication agent for niri";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = polkitExec;
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # For populating file associations in plasma apps in niri
  environment.etc."/xdg/menus/applications.menu" = lib.mkIf isPlasma {
    text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  };
}
