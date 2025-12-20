{ config, pkgs, ... }:

{
  # Virt-Manager
  programs.virt-manager.enable = true;
  users.groups.libvertd.members = [ "neo" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # VMWare
 # virtualisation.vmware.host.enable = true;

  #Quickemu
 # environment.systemPackages = with pkgs; [ quickemu ];
  
  # VirtualBox
/*  users.extraGroups.vboxusers.members = [ "neo" ];
 # nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox.host = {
    enable = true;
    # Unfree Oracle Extensions
    enableExtensionPack = true;
  }; */
}
