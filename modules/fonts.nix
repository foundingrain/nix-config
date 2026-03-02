{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts._0xproto
    miracode
    monocraft
    noto-fonts
  ];
}
