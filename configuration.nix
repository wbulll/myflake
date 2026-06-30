{
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/services/sddm.nix
    ./modules/core/packages.nix
    ./modules/core/users.nix
    ./modules/services/daemons.nix
    ./modules/core/nvim.nix
  ];

  # ============================================================================
  # BOOT & NIX SETTINGS
  # ============================================================================
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };

  # ============================================================================
  # HARDWARE & DISK SERVICES
  # ============================================================================
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    i2c.enable = true;
    enableRedistributableFirmware = true;
    sane.enable = true;
  };

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # ============================================================================
  # NETWORKING & HOST
  # ============================================================================
  networking = {
    hostName = "oto";
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # ============================================================================
  # LOCALIZATION & TIME
  # ============================================================================
  time.timeZone = "Europe/Riga";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "lv_LV.UTF-8";
      LC_IDENTIFICATION = "lv_LV.UTF-8";
      LC_MEASUREMENT = "lv_LV.UTF-8";
      LC_MONETARY = "lv_LV.UTF-8";
      LC_NAME = "lv_LV.UTF-8";
      LC_NUMERIC = "lv_LV.UTF-8";
      LC_PAPER = "lv_LV.UTF-8";
      LC_TELEPHONE = "lv_LV.UTF-8";
      LC_TIME = "lv_LV.UTF-8";
    };
  };

  services.xserver.xkb = {
    layout = "lv";
    variant = "apostrophe";
  };

  # ============================================================================
  # DESKTOP ENVIRONMENT, WAYLAND & THEMING
  # ============================================================================
  programs.niri.enable = true;
  xdg.portal.enable = true;

  environment.sessionVariables = {
    NH_FLAKE = "/home/oto/nixos-config";
    QT_QPA_PLATFORM = "wayland;xcb";
    SAL_USE_VCLPLUGIN = "gtk3";
  };

  # pkgs
  environment.systemPackages = with pkgs; [
    bibata-cursors
    gnome-themes-extra
    papirus-icon-theme
  ];

  #Cursor

  environment.sessionVariables = {
    QS_ICON_THEME = "Papirus-Dark";
    GTK_THEME = "Adwaita-dark"; # Forces the GTK theme globally

    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  #GTK
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = false; # Set to true if you want to prevent users from changing these
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "Adwaita-dark";
            icon-theme = "Papirus-Dark";
            cursor-theme = "Bibata-Modern-Ice";
          };
        };
      }
    ];
  };

  #Qt
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # ============================================================================
  # AUDIO, BLUETOOTH & CUSTOM MODULES
  # ============================================================================

  services.pipewire = {
    enable = true;
    package = pkgs-stable.pipewire;
    alsa.support32Bit = pkgs.lib.mkForce false;

    alsa = {
      enable = true;
      #      support32Bit = false; #######izm
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      package = pkgs-stable.wireplumber;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = false;
        FastConnectable = true;
      };
      Policy.AutoEnable = true;
    };
  };

  # ============================================================================
  # APPLICATIONS (System Level)
  # ============================================================================
  programs = {
    steam.enable = true;
    firefox.enable = true;
    xfconf.enable = true;

    localsend = {
      enable = true;
      openFirewall = true;
    };

    dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
  };

  # ============================================================================
  # STATE VERSION
  # ============================================================================
  system.stateVersion = "25.05";
}
