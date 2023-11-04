{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.fish;
in {
  options.randomscanian.programs.fish = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable the fish shell";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [grc];
    programs.fish = {
      enable = true;
      shellInit = ''
        function fish_greeting
        end
      '';
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      plugins = [
        {
          name = "bang-bang";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-bang-bang";
            rev = "816c66df34e1cb94a476fa6418d46206ef84e8d3";
            hash = "sha256-35xXBWCciXl4jJrFUUN5NhnHdzk6+gAxetPxXCv4pDc=";
          };
        }
        {
          name = "grc";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-grc";
            rev = "61de7a8a0d7bda3234f8703d6e07c671992eb079";
            hash = "sha256-NQa12L0zlEz2EJjMDhWUhw5cz/zcFokjuCK5ZofTn+Q=";
          };
        }
      ];
    };
  };
}
