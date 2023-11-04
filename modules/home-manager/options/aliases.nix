{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.options.aliases;
in {
  options.randomscanian.options.aliases = with types; {
    aliases = mkOption {
      type = attrsOf str;
      default = {};
      description = "List of aliases to enable";
    };
    packages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Packages needed for aliases";
    };
  };

  config = {
    home.packages = cfg.packages;
    home.shellAliases = cfg.aliases;
  };
}
