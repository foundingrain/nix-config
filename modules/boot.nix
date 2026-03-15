{ config, lib, ... }:

let
  cfg = config.my.boot;

  findImage =
    dir: base:
    if dir == null || !(builtins.pathExists dir) then
      null
    else
      let
        files = builtins.attrNames (builtins.readDir dir);
        matches = lib.sort lib.lessThan (
          builtins.filter (name: builtins.match "^${base}\\.[^./]+$" name != null) files
        );
      in
      if matches == [ ] then null else dir + "/${builtins.head matches}";

  limineLogo = findImage cfg.imageDir "limine-logo";
  plymouthLogo = findImage cfg.imageDir "plymouth-logo";
in
{
  options.my.boot.imageDir = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = "Directory containing optional boot logo images.";
  };

  config = lib.mkMerge [
    {
      boot = {
        loader = {
          efi.canTouchEfiVariables = true;
          limine = {
            enable = true;
          };
        };

        initrd.systemd.enable = true;

        plymouth = {
          enable = true;
          theme = "breeze";
        };

        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "video=efifb:nobgrt"
        ];
      };
    }

    (lib.mkIf (limineLogo != null) {
      boot.loader.limine.style.wallpapers = [ limineLogo ];
    })

    (lib.mkIf (plymouthLogo != null) {
      boot.plymouth.logo = plymouthLogo;
    })
  ];
}
