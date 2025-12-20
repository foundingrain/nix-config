{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    nix-ld
    nix-output-monitor
  ];

  programs.nix-ld.enable = true;
  programs.nh.enable = true;
}
