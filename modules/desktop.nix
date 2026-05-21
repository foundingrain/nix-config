{
  lib,
  ...
}:

{
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./mango.nix
    ./niri.nix
    ./noctalia.nix
  ];

  options.neos.desktop.enable = lib.mkEnableOption "desktop environment";
}
