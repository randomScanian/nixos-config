{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.options.shell;
in {
  options.randomscanian.options.shell = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable custom shell config";
    };
  };

  config = mkIf cfg.enable {
    programs.nix-index.enable = true;
    programs.nix-index.enableFishIntegration = true;
    programs.direnv.enableFishIntegration = true;
    randomscanian.programs.fish.enable = true;
    programs.fish.interactiveShellInit = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
}
