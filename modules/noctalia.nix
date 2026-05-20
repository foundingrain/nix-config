{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
