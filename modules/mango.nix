{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.neos.desktop.enable {
    programs.mango.enable = true;

    environment.systemPackages = with pkgs; [
      foot
      rofi
    ];
  };
}
