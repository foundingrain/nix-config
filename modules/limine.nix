{ config, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      rememberLastEntry = true;
      # limine.style.wallpapers = [  ];
    };
  };
}
