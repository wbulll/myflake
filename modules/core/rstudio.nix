{
  config,
  lib,
  pkgs-stable,
  ...
}: {
  options.modules.rstudio.enable = lib.mkEnableOption "RStudio environment with data science packages";

  config = lib.mkIf config.modules.rstudio.enable {
    environment.systemPackages = [
      (pkgs-stable.rstudioWrapper.override {
        packages = with pkgs-stable.rPackages; [
          # Core
          broom
          dplyr
          ggplot2
          markdown
          snakecase
          tidyverse
          writexl

          corrplot
          ggpubr
          tableone

          cobalt
          gbm
          gtsummary
          lmtest
          Matching
          MatchIt
          modelsummary
          optmatch
          rgenoud
          sandwich
          smd
        ];
      })
    ];
  };
}
