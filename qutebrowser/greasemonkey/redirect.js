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
  if (location.hostname === "twitter.com" || location.hostname === "x.com") {
    location.href = url.replace(/(?:twitter|x)\.com/, "nitter.net");
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
