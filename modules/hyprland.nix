{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.neos.desktop.enable {
    programs = {
      hyprland.enable = true;
      hyprland.xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
      	pkgs.xdg-desktop-portal-hyprland
	pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = [ "hyprland" "gtk" ];
    };

    environment.systemPackages = with pkgs; [
      awww
      blueman
      brightnessctl
      cliphist
      fuzzel
      hyprlauncher
      hyprlock
      hyprpaper
      hyprpicker
      libnotify
      networkmanagerapplet
      pavucontrol
      swaynotificationcenter
      waybar
      wlogout
      wl-clipboard
      wofi
    ];

    security.polkit.enable = true;

    # Hint Electron apps to use Wayland (Optional)
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
