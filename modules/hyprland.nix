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
      hyprlock.enable = true;
      waybar.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      config.common.default = "*";
    };

    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
      awww
      brightnessctl
      cliphist
      fuzzel
      hyprpaper
      hyprpicker
      libnotify
      networkmanagerapplet
      swaynotificationcenter
      wlogout
      wl-clipboard
      wofi
    ];

    security.polkit.enable = true;

    # Hint Electron apps to use Wayland (Optional)
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
