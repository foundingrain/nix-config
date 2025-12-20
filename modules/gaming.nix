{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bottles
    gamescope
    goverlay
    heroic
    lutris
    mangohud
    protontricks
    protonup-qt
    winetricks
    wineWowPackages.staging
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    localNetworkGameTransfers.openFirewall = true;
  };
}
