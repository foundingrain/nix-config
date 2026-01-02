{ config, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        # rememberLastEntry = true; # might not exist?
        # style.wallpapers = [  ];
      };
    };

    plymouth = {
      enable = true;
      # logo = ..;
      theme = "breeze";
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
