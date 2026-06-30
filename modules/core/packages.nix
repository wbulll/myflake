{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  # ============================================================================
  # FONTS
  # ============================================================================
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      font-awesome
      corefonts
      vista-fonts
      nerd-fonts.symbols-only
    ];
  };

  # ============================================================================
  # SYSTEM PACKAGES
  # ============================================================================
  environment.systemPackages = with pkgs; [
    # --- Base ---
    syncthing
    zettlr
    texliveBasic
    lumafly
    lue
    resources
    imagemagick
    ffmpeg
    mpvpaper
    mullvad-browser
    alacritty
    udiskie
    polkit_gnome
    kdePackages.qtwayland
    qt6.qtwayland
    nautilus
    gimp
    loupe
    wvkbd
    papirus-icon-theme

    # --- System & Wayland Tools ---
    cliphist
    bazaar
    grim
    jq
    kanshi
    libnotify
    slurp
    xwayland-satellite
    video2x
    fastfetch
    fishPlugins.tide
    oh-my-posh

    # --- Theming ---
    adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    papirus-icon-theme
    pywalfox-native
    waypaper
    glib
    spicetify-cli
    gsettings-desktop-schemas
    gowall

    # --- Utilities ---
    bat
    bc
    btop
    exfatprogs
    fzf
    git
    gparted
    mission-center
    nix-output-monitor
    nvd
    p7zip
    pavucontrol
    pciutils
    poppler
    steam-run
    unzip
    usbutils
    yazi
    zip
    zoxide
    brightnessctl
    sof-firmware
    alsa-utils
    ddcutil
    bibata-cursors
    wl-clipboard
    gpu-screen-recorder

    # --- Terminal & Shell ---
    kitty
    ripdrag
    easyeffects

    # --- Multimedia ---
    ani-cli
    cava
    lrcget
    mpd
    mpv
    rmpc
    shotwell
    vlc
    qbittorrent

    # --- Office & Typing ---
    libreoffice-fresh
    obsidian
    zotero
    onlyoffice-desktopeditors

    # --- Misc ---
    kdePackages.okular
    #    pkgs-stable.librewolf
    tor-browser
  ];
}
