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

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      ${pkgs.fastfetch}/bin/fastfetch

      # Initialize Oh My Posh with a gorgeous theme
      oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json' | source
    '';
  };
}
