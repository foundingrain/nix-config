{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    easyeffects
    signal-desktop
    telegram-desktop
    vesktop
  ];
  programs = {
    noisetorch.enable = true;
  };
}
