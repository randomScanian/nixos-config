# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.nur.overlay
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    gc = {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  security.polkit = {
    enable = true;
  };

  services.pcscd.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = true;
    enableSSHSupport = true;
  };

  networking.resolvconf.dnsExtensionMechanism = false;
  imports =
    map (n: "${./programs}/${n}") (builtins.attrNames (builtins.readDir ./programs));
}
