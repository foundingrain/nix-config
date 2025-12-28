{ config, ... }:
{
  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi
      path: uuid(75ff7c8c-6e10-44eb-890b-e0160dfff8f0):/EFI/Microsoft/Boot/bootmgfw.efi
  '';
}
