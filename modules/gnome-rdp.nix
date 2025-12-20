{ config, pkgs, ... }:

{
  services = {
    gnome.gnome-remote-desktop.enable = true;
    displayManager.autoLogin.enable = false;
    getty.autologinUser = null;
  };

  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };

  networking.firewall.allowedTCPPorts = [ 3389 ];
}
