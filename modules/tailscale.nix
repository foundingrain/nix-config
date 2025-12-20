{ config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraDaemonFlags = [ "--no-logs-no-support" ]; # disable telemetry
  };

  systemd.user.services.tailscale-systray = {
    description = "Tailscale Systray";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tailscale}/bin/tailscale systray";
      Restart = "on-failure";
    };
  };
}
