{ config, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    limine.enable = true;
    # limine.style.wallpapers = [  ];
  };
}
