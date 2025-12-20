{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    github-desktop
    # Java
    #jetbrains.jdk
    #jetbrains.idea-ultimate
    # React
    #nodePackages_latest.nodejs
    #vscode
    # Python
    python3
    go
  ];
}
