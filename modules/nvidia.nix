{ config, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = { 
    enable = true;
  };

  # Load Nvidia driver from Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Experimental, can cause sleep/suspend to fail.
    # Enable if graphical corruption issues or app crashes after waking from sleep.
    # Saves entire VRAM to /tmp/ instead of just the essentials.
    powerManagement.enable = false;

    # Turns off GPU when not in use
    powerManagement.finegrained = false;

    # Should only be set to false if GPU is older than 20-Series.
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
