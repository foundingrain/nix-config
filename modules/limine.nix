{ config, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      # rememberLastEntry = true; # might not exist?
      # limine.style.wallpapers = [  ];
    };
  };
}
