{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.wine;
in {
  options.randomscanian.programs.wine = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable support for Wine.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      winePackages.fonts
      winetricks
    ];
  };
}
