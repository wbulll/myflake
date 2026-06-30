{
  config,
  pkgs,
  ...
}: {
  security.polkit.enable = true;

  services = {
    flatpak.enable = true;
    power-profiles-daemon.enable = true;
    dbus.implementation = "broker";
    ipp-usb.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    upower.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [
        epson-201401w
        cups-filters
        cups-browsed
      ];
    };
  };

  systemd.user.services = {
    kanshi = {
      description = "Kanshi output autoconfig daemon";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi";
        Restart = "always";
        RestartSec = "5";
      };
    };

    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
