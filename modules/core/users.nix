{
  config,
  pkgs,
  ...
}: {
  users.users.oto = {
    isNormalUser = true;
    description = "oto";
    extraGroups = [
      "networkmanager"
      "wheel"
      "i2c"
      "scanner"
      "lp"
      "video"
      "input"
    ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };










programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      ${pkgs.fastfetch}/bin/fastfetch

      # Initialize Oh My Posh using the theme bundled within the Nix store
      oh-my-posh init fish --config ${pkgs.oh-my-posh}/share/oh-my-posh/themes/catppuccin_mocha.omp.json | source
    '';
  };









}
