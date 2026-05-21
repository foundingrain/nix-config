{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.neos.desktop.enable {
    programs.mangowc.enable = true;

    environment.systemPackages = with pkgs; [
      foot
      rofi
    ];
  };
}
