{
  config,
  lib,
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
  home.shellAliases = {
    gs = "git status";
    ts = "tailscale";
    mvpn = "mullvad";
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = "Vimix-white-cursors";
      package = pkgs.vimix-cursors;
      size = 16;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = null; # new behavior
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.appindicator.extensionUuid
        pkgs.gnomeExtensions.blur-my-shell.extensionUuid
        pkgs.gnomeExtensions.caffeine.extensionUuid
        pkgs.gnomeExtensions.launch-new-instance.extensionUuid
        pkgs.gnomeExtensions.gsconnect.extensionUuid
        pkgs.gnomeExtensions.system-monitor-next.extensionUuid
        pkgs.gnomeExtensions.tiling-assistant.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/tiling-assistant" = {
      enable-raise-tile-group = false;
      enable-tiling-popup = false;
      maximize-with-gap = true;
      single-screen-gap = 12;
      window-gap = 12;
    };

    "org/gnome/desktop/interface" = {
      accent-color = "orange";
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      close = [ "<Super>q" ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        # Register custom keybindings
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

    nixvim = {
      enable = true;
      plugins.treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };
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
