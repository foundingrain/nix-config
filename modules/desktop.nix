{
  lib,
  ...
}:

{
  imports = [
    ./gnome.nix
    ./plasma.nix

    # ./hyprland.nix
    ./mango.nix
    ./niri.nix
    ./noctalia.nix
  ];

  options.neos.desktop = {
    enable = lib.mkEnableOption "desktop environment";
    gnome.enable = lib.mkEnableOption "GNOME desktop";
    plasma.enable = lib.mkEnableOption "KDE Plasma desktop";
  };
}
