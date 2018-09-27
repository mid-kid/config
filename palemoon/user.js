// NOTE: This is tailored towards Palemoon and palemoon only.
// I leave a bunch of Firefox settings untweaked because I like their *Palemoon* defaults or they just don't exist there.
// For the same reason, I tweak some settings that aren't available in Firefox (anymore).

// Basic settings
user_pref("browser.startup.page", 0);  // Show a blank page on startup
user_pref("general.smoothScroll", false);  // Disable smooth scrolling
user_pref("general.warnOnAboutConfig", false);  // ...seriously?
user_pref("layout.spellcheckDefault", 0);  // Disable spelling check
user_pref("status4evar.status", 3);  // Show status in pop-up
user_pref("status4evar.status.linkOver", 3);  // Show link in pop-up
user_pref("status4evar.status.default", false);  // Don't show the "Done" status

// WARNING: This is a bad idea security-wise, but malfunctioning sites suck even worse
user_pref("security.OCSP.enabled", 0);
user_pref("security.ssl.enable_ocsp_must_staple", false);
user_pref("security.ssl.enable_ocsp_stapling", false);

// Privacy/Security settings
user_pref("privacy.donottrackheader.enabled", true);  // Tell websites I don't like what they're doing
user_pref("network.http.speculative-parallel-limit", 0);  // Disable link pre-fetching
user_pref("media.peerconnection.enabled", false);  // Disable WebRTC
user_pref("webgl.disabled", true);  // Disable WebGL
user_pref("canvas.poisondata", true);  // Poison canvas data
user_pref("plugins.enumerable_names", "");  // Don't tell what plugins I have enabled
user_pref("extensions.blocklist.enabled", false);  // Disable plugin/extension blocklist
