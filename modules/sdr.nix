{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gqrx
    qsstv
    rtl-sdr
    sdrpp
  ];

  hardware.rtl-sdr.enable = true;
}
