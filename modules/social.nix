{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vesktop
    signal-desktop
    telegram-desktop
  ];
  programs = {
    noisetorch.enable = true;
  };
}
