{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.firefox;
in {
  options.randomscanian.programs.firefox = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable support for PrismLauncher";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        randomscanian = {
          bookmarks = [
            {
              name = "wikipedia";
              tags = ["wiki"];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
            {
              name = "kernel.org";
              url = "https://www.kernel.org";
            }
            {
              name = "Nix sites";
              toolbar = true;
              bookmarks = [
                {
                  name = "homepage";
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  tags = ["wiki" "nix"];
                  url = "https://nixos.wiki/";
                }
              ];
            }
          ];
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            sponsorblock
            privacy-badger
            dracula-dark-colorscheme
            darkreader
            tabcenter-reborn
          ];
          search = {
            force = true;
            default = "Google";
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@no"];
              };
              "NixOS Wiki" = {
                urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
                iconUpdateURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@nw"];
              };
              "Youtube" = {
                urls = [{template = "https://youtube.com/results?search_query={searchTerms}";}];
                definedAliases = ["@y"];
              };
              "Google".metaData.alias = "@g";
            };
          };
          settings = {
            "general.smoothScroll" = true;
            "general.autoscroll" = true;
            "browser.tabs.firefox-view" = false;
          };
          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
            user_pref("media.ffmpeg.vaapi.enabled", true);
            user_pref("media.rdd-vpx.enabled", true);
            user_pref(browser.sessionstore.max_windows_undo, 20);
          '';
          userChrome = ''
            #TabsToolbar{ visibility: collapse !important }
          '';
          userContent = ''
          '';
        };
      };
    };
  };
}
