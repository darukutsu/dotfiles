project ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  i Biome found the configuration file /home/daru/.config/biome/biome.json outside of the current working directory /home/daru/.config. If the configuration enables the scanner, Biome might scan the whole file system. This behaviour will be fixed in the next major version.
  

// ==UserScript==
// @name        Redirect webpages
// @version     1.0.0
// @description Redirect webpages
// @run-at      document-start
// ==/UserScript==

//var current_location = content.document.location;
// @include     https://*.com/*

//if(content.document.location == "http://google.com"){
//    window.location.replace("http://yahoo.com")
//}

(function () {
	var url = location.href;

	// Twitter -> Nitter
	//if (/(?:twitter|^x)\.com\//.test(url)) {
	if (
		location.hostname === "twitter.com" ||
		location.hostname === "x.com" ||
		location.hostname === "xeezz.com" ||
		location.hostname === "fixupx.com"
	) {
		location.href = url.replace(
			/(?:twitter|fixupx|xeezz|x)\.com/,
			"nitter.kareem.one",
		);
		return;
	}

	// Instagram -> Imginn
	if (/instagram\.com\//.test(url)) {
		location.href = url
			.replace(/instagram\.com/, "imginn.com")
			.replace(/(?:reel|tv)/, "p")
			.replace(/[?#].*$/, "");
		return;
	}

	// Old Reddit Redirect
	//if (/(?:new|www)\.reddit\.com\//.test(url)) {
	//  location.href = url.replace(/(?:new|www)\./, "old.");
	//  return;
	//}

	// Reddit Redirect > Teddit
	//if (/www\.reddit\.com\//.test(url)) {
	//  location.href = url.replace(/www\.reddit\.com/, 'teddit.net.');
	//  return;
	//}

	// Delete the cookie message
	//var x = document.getElementsByClassName("infobar-toaster-container");
	//for (var y of x) {
	//  y.remove();
	//}

	//Quora Redirect
	//if (/www\.quora\.com\//.test(url)) {
	//  location.href = url.replace(/www\.quora\.com/, 'quetre.iket.me');
	//  return;
	//}
})();
