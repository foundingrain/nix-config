{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    easyeffects
    signal-desktop
    telegram-desktop
  ];
  programs = {
    noisetorch.enable = true;
  };
}
