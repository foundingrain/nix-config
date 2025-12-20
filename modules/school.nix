{ config, pkgs, ...}:

{
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wireshark
  ];

  users.users.neo.extraGroups = [ "wireshark" ];
}
