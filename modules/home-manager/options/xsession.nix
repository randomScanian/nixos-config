{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.options.xsession;
in {
  options.randomscanian.options.xsession = with types; {
    autostart = mkOption {
      type = attrsOf str;
      default = {};
      description = "things to run before starting window manager";
    };
    packages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Packages needed for autostart";
    };
  };

  config = {
    home.packages = cfg.packages;
    xsession.profileExtra = cfg.autostart;
  };
}
