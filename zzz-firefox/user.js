/*** [SECTION XXXX]: MY SETTINGS ***/

user_pref("apz.overscroll.enabled", false);  // While not default on Linux, this behavior is annoying on Windows
user_pref("browser.download.alwaysOpenPanel", true);  // Show downloads panel when a download starts
user_pref("browser.download.start_downloads_in_tmp_dir", true);  // Please don't save things in downloads when I use "open with"
user_pref("browser.download.useDownloadDir", true);  // Download to the "downloads" folder by default
user_pref("browser.eme.ui.enabled", false);  // Avoid non-free software
user_pref("browser.ml.chat.enabled", false);  // Cloud-based AI should not be provided like this
user_pref("browser.startup.page", 3);  // Keep session across shutdowns
user_pref("browser.tabs.inTitlebar", 0);  // Don't replace the system's title bar
user_pref("browser.tabs.warnOnClose", true);  // Warn when closing multiple tabs
user_pref("browser.toolbars.bookmarks.visibility", "never");  // Don't show the bookmarks toolbar
user_pref("browser.translations.automaticallyPopup", false);  // Great feature copying the worst behavior from chrome
user_pref("browser.uidensity", 1);  // Compact density is best density
user_pref("cookiebanners.service.mode", 2);  // Block cookie banners
user_pref("cookiebanners.service.mode.privateBrowsing", 2);  // ...everywhere
user_pref("extensions.pocket.enabled", false);  // 3rd party extension, proprietary
user_pref("general.smoothScroll", false);  // I prefer quick/fast scrolling
user_pref("layout.spellcheckDefault", 0);  // Disable spellchecking
user_pref("media.eme.enabled", false);  // Avoid non-free software
user_pref("media.gmp-gmpopenh264.autoupdate", false);  // Don't download binaries
user_pref("media.gmp-widevinecdm.autoupdate", false);  // Don't download binaries
user_pref("network.trr.mode", 5);  // Applications should stop trying to avoid the system's DNS resolver
user_pref("places.history.expiration.max_pages", 1000000000);  // Keep history FOREVER!
user_pref("privacy.globalprivacycontrol.enabled", true);  // Another attempt at donottrack, but legally binding this time
user_pref("privacy.sanitize.sanitizeOnShutdown", false);  // Don't clear everything on shutdown
user_pref("signon.rememberSignons", false);  // Don't ask to save passwords
user_pref("widget.gtk.overlay-scrollbars.enabled", false);  // GTK3's overlay scrollbars are terrible

// Disable "handholding" security
// I know what I install/browse, and I don't want a 3rd party to decide for me
user_pref("browser.safebrowsing.downloads.enabled", false);  // Disable safebrowsing
user_pref("browser.safebrowsing.malware.enabled", false);  // Disable safebrowsing
user_pref("browser.safebrowsing.phishing.enabled", false);  // Disable safebrowsing
user_pref("security.OCSP.enabled", 0);  // Disable OCSP
user_pref("extensions.langpacks.signatures.required", false);  // Disable extension signing
user_pref("xpinstall.signatures.required", false);  // Disable extension signing
user_pref("xpinstall.whitelist.required", false);  // Disable extension whitelist

// Try not breaking sites
user_pref("dom.security.https_only_mode", false);  // Don't warn when a site only supports http
user_pref("security.ssl.require_safe_negotiation", false);  // Not any worse than allowing HTTP connections, padlock shows as broken anyway

// Relly big and leaky browser features
//user_pref("webgl.disabled", false);  // WebGL
// Unfortunately, too much relies on this now

// Lepton (theme) settings
user_pref("userChrome.rounding.square_button", true);
user_pref("userChrome.rounding.square_dialog", true);
user_pref("userChrome.rounding.square_panel", true);
user_pref("userChrome.rounding.square_panelitem", true);
user_pref("userChrome.rounding.square_menupopup", true);
user_pref("userChrome.rounding.square_menuitem", true);
user_pref("userChrome.rounding.square_infobox", true);
user_pref("userChrome.rounding.square_toolbar", true);
user_pref("userChrome.rounding.square_field", true);
user_pref("userChrome.rounding.square_urlView_item", true);
user_pref("userChrome.rounding.square_checklabel", true);
user_pref("userChrome.tab.box_shadow", true);
user_pref("userChrome.hidden.private_indicator", true);
user_pref("userChrome.hidden.urlbar_iconbox", true);
user_pref("userChrome.urlView.move_icon_to_left", true);
user_pref("userChrome.urlView.go_button_when_typing", true);

user_pref("_user.js.parrot", "SUCCESS");
