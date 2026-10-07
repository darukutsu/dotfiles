// ==UserScript==
// @name         Zscaler Autoclicker
// @match        *://*/*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    console.log('[Zscaler test] injected:', location.href);

    const observer = new MutationObserver(() => {
        const button = [...document.querySelectorAll('input[type="submit"]')]
            .find(x => x.value.trim() === 'Continue');

        if (button) {
            console.log('[Zscaler test] FOUND BUTTON', button);

            observer.disconnect();
            button.click();
        }
    });

    observer.observe(document.documentElement, {
        childList: true,
        subtree: true
    });
})();
