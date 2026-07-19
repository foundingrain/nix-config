{ config, ... }:

{
  services.syncthing = {
    enable = true;
    user = "neo";
    group = "users";
    dataDir = "/home/neo";
    openDefaultPorts = true;
  };
}
