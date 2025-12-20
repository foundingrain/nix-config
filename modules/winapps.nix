{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    freerdp
  ];
  users.users.neo.extraGroups = [ "docker" ];
}
