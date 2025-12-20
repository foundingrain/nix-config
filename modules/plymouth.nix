{ config, pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      # logo = ..;
      # theme = "breeze";
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
