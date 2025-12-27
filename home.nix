{
  config,
  pkgs,
  hmUser,
  ...
}:

{
  # home.username = "neo";
  # home.homeDirectory = "/home/neo";
  home.username = hmUser;
  home.homeDirectory = "/home/${hmUser}";
  home.sessionVariables = {
    EDITOR = "nvim";
    SAL_USE_VCLPLUGIN = "gtk3";
  };

  programs = {
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    bash = {
      enable = true;
    };

    btop = {
      enable = true;
      settings.vim_keys = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    git = {
      enable = true;
      settings.user.name = "foundingrain";
      settings.user.email = "foundingrain@pm.me";
    };

    kitty = {
      enable = true;
      settings = {
        shell = "fish";
        font_size = 12;
        background_opacity = 0.8;
        confirm_os_window_close = -1;
      };
      themeFile = "Cyberpunk-Neon";
    };

    ranger = {
      enable = true;
      extraConfig = ''
        set preview_images true
        set preview_images_method kitty
      '';
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      # presets = "nerd-font-symbols";
    };
  };

  home.stateVersion = "25.11";
}
