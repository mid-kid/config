/*** [SECTION XXXX]: MY SETTINGS ***/

// Settings to consider
// browser.cache.disk.enable - keeping sites locally can speed shit up on boot
// Left off at: dom.push.enabled

user_pref("accessibility.typeaheadfind", false);  // Don't search text when typing in a page
user_pref("browser.download.useDownloadDir", true);  // Download to the "downloads" folder by default
user_pref("browser.startup.page", 3);  // Keep session across shutdowns
user_pref("dom.security.https_only_mode", false);  // Don't warn when a site only supports http
user_pref("extensions.pocket.enabled", false);  // 3rd party extension, proprietary
user_pref("general.smoothScroll", false);  // I prefer quick/fast scrolling
user_pref("keyword.enabled", true);  // Enable search in the URL bar
user_pref("layout.spellcheckDefault", 0);  // Disable spellchecking
user_pref("network.dns.disableIPv6", false);  // This is fucking retarded
user_pref("network.trr.mode", 5);  // Applications should stop trying to avoid the system's DNS resolver
user_pref("privacy.resistFingerprinting.letterboxing", false);  // Don't mess with the content size
user_pref("privacy.sanitize.sanitizeOnShutdown", false);  // Don't clear everything on shutdown
user_pref("signon.rememberSignons", false);  // Don't ask to save passwords
user_pref("widget.non-native-theme.enabled", false);  // I prefer native widgets...
user_pref("browser.tabs.drawInTitlebar", false);  // Use native title bar, don't have spacer next to tabs

// Disable "handholding" security
// I know what I install/browse, and I don't want a 3rd party to decide for me
user_pref("browser.safebrowsing.downloads.enabled", false);  // Disable safebrowsing
user_pref("browser.safebrowsing.malware.enabled", false);  // Disable safebrowsing
user_pref("browser.safebrowsing.phishing.enabled", false);  // Disable safebrowsing
user_pref("security.OCSP.enabled", 0);  // Disable OCSP
user_pref("xpinstall.signatures.required", false);  // Disable extension signing
user_pref("xpinstall.whitelist.required", false);  // Disable extension whitelist

// Try not breaking sites
user_pref("network.http.referer.XOriginPolicy", 0);
//user_pref("network.http.referer.XOriginTrimmingPolicy", 0);
//user_pref("privacy.firstparty.isolate", false);

user_pref("_user.js.parrot", "SUCCESS");
