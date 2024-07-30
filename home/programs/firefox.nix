{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
  imports = [
    inputs.nur.nixosModules.nur
  ];

  programs.firefox = {
    enable = true;
    languagePacks = ["de" "en-US"];

    /*
    ---- POLICIES ----
    */
    # Check about:policies#documentation for options.
    policies = {
      "3rdparty".Extensions = {
        # https://github.com/gorhill/uBlock/blob/master/platform/common/managed_storage.json
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            uiTheme = "dark";
            uiAccentCustom = true;
            uiAccentCustom0 = "#8300ff";
            cloudStorageEnabled = mkForce false; # Security liability?
            importedLists = [
              "https://filters.adtidy.org/extension/ublock/filters/3.txt"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            ];
            externalLists = lib.concatStringsSep "\n" importedLists;
          };
          selectedFilterLists = [
            "CZE-0"
            "adguard-generic"
            "adguard-annoyance"
            "adguard-social"
            "adguard-spyware-url"
            "easylist"
            "easyprivacy"
            "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            "plowe-0"
            "ublock-abuse"
            "ublock-badware"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "urlhaus-1"
          ];
        };
      };

      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = false;
      };

      Homepage = {
        StartPage = "none";
      };

      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      PasswordManagerEnabled = false;
    };

    profiles."default" = {
      search = {
        default = "DuckDuckGo";
        force = true;
        engines = {
          "Nix Options" = {
            urls = [{template = "https://search.nixos.org/options?type=options&query={searchTerms}";}];
            iconURL = "https://nixos.org/favicon.ico";
            definedAliases = ["@no"];
          };

          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
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

          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };

          "GitHub" = {
            urls = [{template = "https://github.com/search?q={searchTerms}&type=repositories";}];
            iconURL = "https://github.com/favicon.ico";
            definedAliases = ["@gh"];
          };

          "Home Manager" = {
            urls = [{template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";}];
            iconURL = "https://nixos.org/favicon.ico";
            definedAliases = ["@hm"];
          };

          "YouTube" = {
            urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
            iconURL = "https://www.youtube.com/favicon.ico";
            definedAliases = ["@yt"];
          };

          # Disable default search engines
          "Amazon.de".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          # "DuckDuckGo".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        ff2mpv
        i-dont-care-about-cookies
        privacy-badger
        to-deepl
        ublock-origin
        unpaywall
        youtube-nonstop
      ];

      # https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
      settings = {
        # disable Studies
        # disable Normandy/Shield [FF60+]
        # Shield is a telemetry system that can push and test "recipes"
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;

        # Disable updates (pretty pointless with nix)
        "app.update.channel" = "default";

        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "strict";
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.discovery.enabled" = false;
        "browser.laterrun.enabled" = false;
        
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =
          false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
          false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = false;
        
        "browser.search.region" = "DE";
        "browser.search.widget.inNavBar" = true;

        "browser.protections_panel.infoMessage.seen" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.ssb.enabled" = true;
        
        "browser.startup.homepage.StartPage" = "none";
        "browser.startup.page.StartPage" = "none";
        
        "browser.toolbars.bookmarks.visibility" = "never";
        
        # Disable all the annoying quick actions
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.openpage" = false;

        "datareporting.policy.dataSubmissionEnable" = false;
        "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;

        "doh-rollout.doneFirstRun" = true;
        
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;

        # Auto enable extensions
        "extensions.autoDisableScopes" = 0;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;

        "gfx.webrender.all" = true; # Force enable GPU acceleration

        "identity.fxaccounts.enabled" = false;

        "media.ffmpeg.vaapi.enabled" = true;
        
        "pref.privacy.disable_button.view_passwords" = false;

        "print.print_footerleft" = "";
        "print.print_footerright" = "";
        "print.print_headerleft" = "";
        "print.print_headerright" = "";

        "privacy.donottrackheader.enabled" = true;
        
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        # Hide the "sharing indicator", it's especially annoying
        # with tiling WMs on wayland
        "privacy.webrtc.legacyGlobalIndicator" = false;

        # Keep the reader button enabled at all times; really don't
        # care if it doesn't work 20% of the time, most websites are
        # crap and unreadable without this
        "reader.parse-on-load.force-enabled" = true;

        "signon.rememberSignons" = false;

        "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes
      };
    };
  };
}
