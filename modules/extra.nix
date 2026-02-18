{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kdenlive
    krita
    libreoffice-fresh
    obs-studio
    qbittorrent
    qpwgraph
    spotify
  ];

  programs.kdeconnect.enable = true;
}
