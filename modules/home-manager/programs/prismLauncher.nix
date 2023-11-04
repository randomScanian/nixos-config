{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.prismLauncher;
in {
  options.randomscanian.programs.prismLauncher = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable support for PrismLauncher";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [prismlauncher-qt5];
  };
}
