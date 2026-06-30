{
  config,
  pkgs,
  ...
}: let
  custom-sddm-astronaut =
    (pkgs.sddm-astronaut.override {
      #embeddedTheme = "japanese_aesthetic";
      embeddedTheme = "pixel_sakura";
    }).overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          mkdir -p $out/share/fonts
          cp -r $out/share/sddm/themes/sddm-astronaut-theme/Fonts/* $out/share/fonts/
        '';
    });
in {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
    enableHidpi = true;
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];
  };

  # Make the newly exposed fonts available globally for SDDM to use
  fonts.packages = [custom-sddm-astronaut];

  environment.systemPackages = with pkgs; [
    custom-sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
