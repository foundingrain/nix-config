{
  config,
  lib,
  pkgs,
  osConfig,
  hmUser,
  inputs,
  ...
}:

{
  # home.username = "neo";
  # home.homeDirectory = "/home/neo";
  home.username = hmUser;
  home.homeDirectory = "/home/${hmUser}";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SAL_USE_VCLPLUGIN = "gtk3";
  };
  home.shellAliases = {
    gs = "git status";
    ts = "tailscale";
    mvpn = "mullvad";
  };
  home.packages = [
    inputs.kickstart-nixvim.packages.${pkgs.system}.default
  ];

  gtk = lib.mkIf osConfig.neos.desktop.gnome.enable {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = "Vimix-white-cursors";
      package = pkgs.vimix-cursors;
      size = 24;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = null; # new behavior
  };

  dconf.settings = lib.mkIf osConfig.neos.desktop.gnome.enable {
    "org/gnome/mutter" = {
      experimental-features = [ "variable-refresh-rate" ];
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.arcmenu.extensionUuid
        pkgs.gnomeExtensions.appindicator.extensionUuid
        pkgs.gnomeExtensions.blur-my-shell.extensionUuid
        pkgs.gnomeExtensions.caffeine.extensionUuid
        pkgs.gnomeExtensions.launch-new-instance.extensionUuid
        pkgs.gnomeExtensions.gsconnect.extensionUuid
        pkgs.gnomeExtensions.system-monitor-next.extensionUuid
        pkgs.gnomeExtensions.tiling-assistant.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [
        "<Alt>space"
        "<Super>space"
      ];
      custom-menu-button-text = "NeosOS";
      menu-button-appearance = "Text";
    };

    "org/gnome/shell/extensions/tiling-assistant" = {
      enable-raise-tile-group = false;
      enable-tiling-popup = false;
      maximize-with-gap = true;
      single-screen-gap = 12;
      window-gap = 12;
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "orange";
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize,icon:";
      resize-with-right-button = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      close = [ "<Super>q" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "Kitty";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "nautilus";
      name = "Launch File Manager";
    };
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
      # font.name = "FiraCode Nerd Font";
      font.name = "0xProto Nerd Font";
      font.size = 13;
      settings = {
        shell = "fish";
        background_opacity = 0.8;
        confirm_os_window_close = -1;
      };
      themeFile = "Cyberpunk-Neon";
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
