{ config, pkgs, ... }:

{
  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kdeplasma-addons

    libreoffice-qt6-fresh
    # qt6ct
  ];
}
