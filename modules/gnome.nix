{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bibata-cursors
    gnome-shell-extensions
    gnome-tweaks
    gnomeExtensions.app-icons-taskbar
    gnomeExtensions.appindicator
    gnomeExtensions.arcmenu
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.notification-timeout
    # gnomeExtensions.paperwm
    gnomeExtensions.system-monitor-next
    gnomeExtensions.tiling-assistant
    gnomeExtensions.user-themes
    gnomeExtensions.vertical-workspaces
    # gnomeExtensions.window-list
    gthumb
    zenity
  ];

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs = {
    dconf.enable = true;
    kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  };
}
