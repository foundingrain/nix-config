{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop
    exfat
    exfatprogs
    fastfetch
    firefox
    fish
    git
    gparted
    kitty
    lolcat
    mpv
    neovim
    ntfs3g
    p7zip
    ranger
    starship
    steam-run-free
    unzip
    vlc
    wget
    wl-clipboard
  ];
}
