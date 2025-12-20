{
  pkgs,
  ...
}:

{

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  /*
    systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  */

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    cliphist
    fuzzel
    kanshi
    networkmanagerapplet
    niriswitcher
    nwg-look
    pavucontrol
    sunsetr
    # swaybg
    swww
    swaylock-effects
    swaylock-fancy
    swaynotificationcenter
    xwayland-satellite
    wlogout
  ];

  programs = {
    niri.enable = true;
    waybar.enable = true;
  };

  services.blueman.enable = true;
}
