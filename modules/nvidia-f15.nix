{ config, pkgs, ... }:

{
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    # Intel and Nvidia busId will differ in other laptops
    intelBusId = "PCI:0:0:2";
    nvidiaBusId = "PCI:0:1:0";
  };
}
