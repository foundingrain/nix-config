{ config, pkgs, ... }:

{
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    cliphist
    hyprpaper
    networkmanagerapplet
    swaynotificationcenter
    wlogout
    wofi
  ];

  # Hint Electron apps to use Wayland (Optional)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
