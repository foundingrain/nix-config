{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    krita
    libreoffice-fresh
    obs-studio
    qbittorrent
    qpwgraph
    spotify
  ];

  programs.kdeconnect.enable = true;
}
