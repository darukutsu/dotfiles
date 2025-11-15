// ==UserScript==
// @name         Invert colors for Falkon through greasemonkey
// @version      1.0
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function () {
  const style =
    "html {-webkit-filter: invert(100%); -moz-filter: invert(100%); -o-filter: invert(100%); -ms-filter: invert(100%); }";
  const head = document.getElementsByTagName("head")[0];
  const styleTag = document.createElement("style");

  styleTag.type = "text/css";
  if (styleTag.styleSheet) {
    styleTag.styleSheet.cssText = style;
  } else {
    styleTag.appendChild(document.createTextNode(style));
  }
  head.appendChild(styleTag);
})();
