// ==UserScript==
// @name         Azure DevOps - Show All Checks Inline
// @namespace    https://tampermonkey.net/
// @version      1.0
// @description  Show all Azure DevOps PR checks directly in the required-checks area
// @match        https://dev.azure.com/*
// @match        https://*.visualstudio.com/*
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    let processing = false;

    function findViewChecks() {
        return [...document.querySelectorAll(
            'span[role="button"].bolt-link'
        )].find(el => /^View \d+ checks$/i.test(el.textContent.trim()));
    }

    function findRequiredChecksContainer() {
        const view = findViewChecks();
        if (!view) return null;

        return view.closest('.status-details-container-row')
            ?.parentElement;
    }

    function findSidebar() {
        // Azure DevOps uses several different panel/dialog structures
        // depending on the current UI version.
        const candidates = [
            '[role="dialog"]',
            '[role="complementary"]',
            '.bolt-panel',
            '.bolt-dock',
            '.bolt-panel-content'
        ];

        for (const selector of candidates) {
            const elements = document.querySelectorAll(selector);

            for (const el of elements) {
                const text = el.textContent || '';

                if (
                    /checks/i.test(text) &&
                    el.offsetParent !== null
                ) {
                    return el;
                }
            }
        }

        return null;
    }

    function copyChecksInline(sidebar) {
        const target = findRequiredChecksContainer();
        if (!target || !sidebar) return false;

        // Don't insert twice
        if (target.querySelector('.tm-inline-checks')) {
            return true;
        }

        /*
         * Find check rows inside the sidebar.
         *
         * Azure DevOps commonly renders these as list items.
         */
        const rows = [
            ...sidebar.querySelectorAll(
                '[role="listitem"], tr, .bolt-list-row'
            )
        ].filter(row => {
            const text = row.textContent?.trim();

            return text &&
                !/^checks?$/i.test(text) &&
                !/^view \d+ checks$/i.test(text);
        });

        if (!rows.length) {
            console.log(
                '[Azure DevOps] Sidebar found, but no check rows found yet.'
            );
            return false;
        }

        const wrapper = document.createElement('div');
        wrapper.className = 'tm-inline-checks';

        wrapper.style.cssText = `
            margin-top: 8px;
            width: 100%;
        `;

        for (const row of rows) {
            const clone = row.cloneNode(true);

            clone.style.display = '';
            clone.style.visibility = 'visible';

            wrapper.appendChild(clone);
        }

        target.appendChild(wrapper);

        console.log(
            '[Azure DevOps] Added',
            rows.length,
            'checks inline.'
        );

        return true;
    }

    function hideSidebar(sidebar) {
        if (!sidebar) return;

        sidebar.style.setProperty('display', 'none', 'important');

        // Sometimes the visible panel is a parent.
        const parent = sidebar.closest(
            '[role="dialog"], [role="complementary"]'
        );

        if (parent && parent !== sidebar) {
            parent.style.setProperty('display', 'none', 'important');
        }
    }

    function expand() {
        if (processing) return;

        const view = findViewChecks();
        if (!view) return;

        // Don't do anything if we've already handled it.
        if (document.querySelector('.tm-inline-checks')) return;

        processing = true;

        console.log('[Azure DevOps] Opening checks panel...');

        view.click();

        // Give React time to render the panel.
        let attempts = 0;

        const timer = setInterval(() => {
            attempts++;

            const sidebar = findSidebar();

            if (sidebar) {
                if (copyChecksInline(sidebar)) {
                    hideSidebar(sidebar);
                    clearInterval(timer);
                    processing = false;
                }
            }

            if (attempts >= 30) {
                clearInterval(timer);
                processing = false;

                console.log(
                    '[Azure DevOps] Could not find checks in sidebar.'
                );
            }
        }, 100);
    }

    // Watch Azure DevOps's dynamically rendered UI.
    const observer = new MutationObserver(() => {
        expand();
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    // Initial attempt
    setTimeout(expand, 500);
})();
