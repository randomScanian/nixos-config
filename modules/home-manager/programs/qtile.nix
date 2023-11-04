{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.qtile;
in {
  options.randomscanian.programs.qtile = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable qtile";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."qtile/config.py".source = "${inputs.assets}/qtile/config.py";
  };
}
