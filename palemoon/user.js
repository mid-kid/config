// NOTE: This is tailored towards Palemoon and palemoon only.
// I leave a bunch of Firefox settings untweaked because I like their *Palemoon* defaults or they just don't exist there.
// For the same reason, I tweak some settings that aren't available in Firefox (anymore).

// Basic settings
user_pref("browser.startup.page", 0);  // Show a blank page on startup
user_pref("general.smoothScroll", false);  // Disable smooth scrolling
user_pref("general.warnOnAboutConfig", false);  // ...seriously?
user_pref("layout.spellcheckDefault", 0);  // Disable spelling check
user_pref("security.ssl.enable_ocsp_stapling", false);  // WARNING: This is a bad idea security-wise, but malfunctioning sites suck even worse

// Privacy/Security settings
user_pref("privacy.donottrackheader.enabled", true);  // Tell websites I don't like what they're doing
user_pref("privacy.trackingprotection.enabled", true);  // Use mozilla's tracking protection (NOTE: sends requests to mozilla)
user_pref("network.http.speculative-parallel-limit", 0);  // Disable link pre-fetching
user_pref("media.peerconnection.enabled", true);  // Disable WebRTC
user_pref("webgl.disabled", true);  // Disable WebGL
user_pref("canvas.poisondata", true);  // Poison canvas data
