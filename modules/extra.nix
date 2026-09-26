{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kdenlive
    krita
    libreoffice
    obs-studio
    qbittorrent
    qpwgraph
    spotify
  ];

  programs.kdeconnect.enable = true;
}
