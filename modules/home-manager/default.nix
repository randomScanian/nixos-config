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
  imports =
    map (n: "${./programs}/${n}") (builtins.attrNames (builtins.readDir ./programs))
    ++ map (n: "${./options}/${n}") (builtins.attrNames (builtins.readDir ./options));
}
