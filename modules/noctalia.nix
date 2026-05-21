{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  config = lib.mkIf config.neos.desktop.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
  };
}
