// ==UserScript==
// @name         Azure DevOps - Collapse Resolved PR Threads + Diffs
// @namespace    https://github.com/
// @version      4.1.0
// @description  Collapse complete resolved PR discussion threads, file headers and associated diffs while keeping active comments visible.
// @match        https://dev.azure.com/*/*/_git/*/pullrequest/*
// @match        https://*.visualstudio.com/*/_git/*/pullrequest/*
// @grant        none
// @run-at       document-idle
// ==/UserScript==

(function () {
    "use strict";

    const COMMENT_SELECTOR = ".repos-discussion-comment";
    const VIEWER_SELECTOR = ".repos-comment-viewer";
    const DIFF_SELECTOR = ".comment-file-diff-container";
    const HEADER_SELECTOR = ".comment-file-header-title";

    const PROCESSED = "data-ado-thread-processed";

    /*
     * ------------------------------------------------------------
     * Detect resolved / closed state.
     * ------------------------------------------------------------
     */
    function isResolvedComment(comment) {
        for (const button of comment.querySelectorAll("button")) {
            const text = button.textContent
                .trim()
                .toLowerCase()
                .replace(/[’']/g, "'");

            if (
                text === "resolved" ||
                text === "closed" ||
                text === "won't fix" ||
                text === "wont fix"
            ) {
                return true;
            }
        }

        return false;
    }

    /*
     * ------------------------------------------------------------
     * Find the thread containing the resolved comment.
     *
     * Prefer Azure DevOps' explicit thread containers.
     *
     * The supplied HTML does not always expose those classes,
     * so there is a conservative fallback.
     * ------------------------------------------------------------
     */
    function findThreadRoot(comment) {
        const explicitThread =
            comment.closest(".repos-discussion-thread");

        if (explicitThread) {
            return explicitThread;
        }

        const explicitDiffThread =
            comment.closest(".repos-diff-comment-thread");

        if (explicitDiffThread) {
            return explicitDiffThread;
        }

        /*
         * Fallback.
         *
         * Start from the comment viewer and find the smallest
         * ancestor that contains the thread reply area.
         */
        const viewer =
            comment.closest(VIEWER_SELECTOR);

        if (!viewer) {
            return null;
        }

        let parent = viewer.parentElement;

        while (parent && parent !== document.body) {
            const viewers =
                parent.querySelectorAll(
                    VIEWER_SELECTOR
                );

            const hasReplyBox =
                parent.querySelector(
                    ".repos-discussion-thread-reply"
                ) !== null;

            /*
             * A thread containing replies has:
             *
             *   one or more comment viewers
             *   + thread reply area
             */
            if (
                hasReplyBox &&
                viewers.length >= 1
            ) {
                return parent;
            }

            /*
             * Don't climb into a huge parent containing
             * multiple independent reply sections.
             */
            const replyAreas =
                parent.querySelectorAll(
                    ".repos-discussion-thread-reply"
                );

            if (replyAreas.length > 1) {
                break;
            }

            parent = parent.parentElement;
        }

        /*
         * Final safe fallback.
         */
        return viewer;
    }

    /*
     * ------------------------------------------------------------
     * Find the diff associated with this thread.
     * ------------------------------------------------------------
     */
    function findAssociatedDiff(thread) {
        /*
         * Diff inside thread.
         */
        const inside =
            thread.querySelector(DIFF_SELECTOR);

        if (inside) {
            return inside;
        }

        /*
         * Look at previous siblings.
         *
         * Typical Azure DevOps structure:
         *
         *   .comment-file-header-title
         *   .comment-file-diff-container
         *   .repos-comment-viewer
         */
        let sibling =
            thread.previousElementSibling;

        while (sibling) {
            if (
                sibling.matches(DIFF_SELECTOR)
            ) {
                return sibling;
            }

            const nested =
                sibling.querySelector(
                    DIFF_SELECTOR
                );

            if (nested) {
                return nested;
            }

            sibling =
                sibling.previousElementSibling;
        }

        /*
         * Look at direct siblings of the thread parent.
         */
        const parent =
            thread.parentElement;

        if (parent) {
            for (const child of parent.children) {
                if (
                    child === thread ||
                    child.contains(thread)
                ) {
                    continue;
                }

                if (
                    child.matches(DIFF_SELECTOR)
                ) {
                    return child;
                }

                const nested =
                    child.querySelector(
                        DIFF_SELECTOR
                    );

                if (nested) {
                    return nested;
                }
            }
        }

        /*
         * Last fallback.
         *
         * Search upward, but NEVER hide the ancestor.
         * We only return the diff itself.
         */
        let ancestor =
            thread.parentElement;

        while (
            ancestor &&
            ancestor !== document.body
        ) {
            const diffs =
                ancestor.querySelectorAll(
                    DIFF_SELECTOR
                );

            if (diffs.length === 1) {
                return diffs[0];
            }

            if (diffs.length > 1) {
                break;
            }

            ancestor =
                ancestor.parentElement;
        }

        return null;
    }

    /*
     * ------------------------------------------------------------
     * Find the file header associated with this thread/diff.
     * ------------------------------------------------------------
     */
    function findAssociatedHeader(thread, diff) {
        /*
         * Header inside thread.
         */
        const inside =
            thread.querySelector(
                HEADER_SELECTOR
            );

        if (inside) {
            return inside;
        }

        /*
         * First look at previous siblings of the thread.
         */
        let sibling =
            thread.previousElementSibling;

        while (sibling) {
            if (
                sibling.matches(
                    HEADER_SELECTOR
                )
            ) {
                return sibling;
            }

            const nested =
                sibling.querySelector(
                    HEADER_SELECTOR
                );

            if (nested) {
                return nested;
            }

            sibling =
                sibling.previousElementSibling;
        }

        /*
         * The header normally sits immediately before
         * the diff.
         */
        if (diff) {
            const header =
                diff.previousElementSibling;

            if (
                header &&
                header.matches(
                    HEADER_SELECTOR
                )
            ) {
                return header;
            }
        }

        /*
         * Search direct siblings of the parent.
         */
        const parent =
            thread.parentElement;

        if (parent) {
            for (const child of parent.children) {
                if (
                    child === thread ||
                    child.contains(thread)
                ) {
                    continue;
                }

                if (
                    child.matches(
                        HEADER_SELECTOR
                    )
                ) {
                    return child;
                }
            }
        }

        return null;
    }

    /*
     * ------------------------------------------------------------
     * Create collapsed bar.
     * ------------------------------------------------------------
     */
    function createCollapsedBar(header) {
        const bar =
            document.createElement("div");

        bar.className =
            "ado-resolved-thread-bar";

        /*
         * Show the filename in the collapsed bar when available.
         */
        let fileName = "";

        if (header) {
            const link =
                header.querySelector(
                    ".comment-file-header-link"
                );

            if (link) {
                fileName =
                    link.textContent.trim();
            }
        }

        const label =
            fileName
                ? `Resolved thread — ${fileName}`
                : "Resolved thread";

        bar.innerHTML = `
            <span class="ado-resolved-icon">✓</span>
            <span class="ado-resolved-text"></span>
            <button
                type="button"
                class="ado-resolved-toggle">
                Show thread & diff
            </button>
        `;

        bar.querySelector(
            ".ado-resolved-text"
        ).textContent = label;

        Object.assign(bar.style, {
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            gap: "10px",
            width: "100%",
            boxSizing: "border-box",
            padding: "7px 12px",
            margin: "4px 0",
            background:
                "var(--palette-neutral-2, #f3f3f3)",
            border:
                "1px solid var(--palette-neutral-10, #ddd)",
            borderRadius: "3px",
            color:
                "var(--palette-neutral-80, #555)",
            fontSize: "12px"
        });

        const icon =
            bar.querySelector(
                ".ado-resolved-icon"
            );

        Object.assign(icon.style, {
            color: "#107c10",
            fontWeight: "bold",
            fontSize: "14px"
        });

        const text =
            bar.querySelector(
                ".ado-resolved-text"
            );

        Object.assign(text.style, {
            flex: "1"
        });

        const button =
            bar.querySelector(
                ".ado-resolved-toggle"
            );

        Object.assign(button.style, {
            cursor: "pointer",
            border: "none",
            background: "transparent",
            color: "#0078d4",
            fontWeight: "600",
            padding: "3px 6px"
        });

        return bar;
    }

    /*
     * ------------------------------------------------------------
     * Create collapse button.
     * ------------------------------------------------------------
     */
    function createCollapseButton() {
        const button =
            document.createElement("button");

        button.type = "button";
        button.className =
            "ado-resolved-collapse";

        button.textContent = "Collapse";

        Object.assign(button.style, {
            cursor: "pointer",
            border: "none",
            background: "transparent",
            color: "#0078d4",
            fontWeight: "600",
            padding: "3px 6px",
            margin: "3px 0"
        });

        return button;
    }

    /*
     * ------------------------------------------------------------
     * Collapse complete thread + header + diff.
     * ------------------------------------------------------------
     */
    function collapseThread(
        thread,
        header,
        diff,
        bar,
        threadDisplay,
        headerDisplay,
        diffDisplay
    ) {
        thread.style.display = "none";

        if (header) {
            header.style.display = "none";
        }

        if (diff) {
            diff.style.display = "none";
        }

        if (!bar.isConnected) {
            thread.parentElement?.insertBefore(
                bar,
                thread
            );
        }

        const button =
            bar.querySelector(
                ".ado-resolved-toggle"
            );

        if (button) {
            button.textContent =
                "Show thread & diff";
        }

        thread.dataset.adoCollapsed =
            "true";

        if (header) {
            header.dataset.adoCollapsed =
                "true";
        }

        if (diff) {
            diff.dataset.adoCollapsed =
                "true";
        }
    }

    /*
     * ------------------------------------------------------------
     * Expand complete thread + header + diff.
     * ------------------------------------------------------------
     */
    function expandThread(
        thread,
        header,
        diff,
        bar,
        threadDisplay,
        headerDisplay,
        diffDisplay
    ) {
        thread.style.display =
            threadDisplay;

        if (header) {
            header.style.display =
                headerDisplay;
        }

        if (diff) {
            diff.style.display =
                diffDisplay;
        }

        delete thread.dataset.adoCollapsed;

        if (header) {
            delete header.dataset.adoCollapsed;
        }

        if (diff) {
            delete diff.dataset.adoCollapsed;
        }

        bar.remove();

        /*
         * Add a small Collapse button at the top
         * of the complete thread.
         */
        const collapseButton =
            createCollapseButton();

        thread.insertBefore(
            collapseButton,
            thread.firstChild
        );

        collapseButton.addEventListener(
            "click",
            () => {
                collapseButton.remove();

                collapseThread(
                    thread,
                    header,
                    diff,
                    bar,
                    threadDisplay,
                    headerDisplay,
                    diffDisplay
                );
            }
        );
    }

    /*
     * ------------------------------------------------------------
     * Process resolved threads.
     * ------------------------------------------------------------
     */
    function processThreads() {
        document
            .querySelectorAll(
                COMMENT_SELECTOR
            )
            .forEach(comment => {

                /*
                 * Only begin from a resolved comment.
                 */
                if (!isResolvedComment(comment)) {
                    return;
                }

                /*
                 * Find complete thread.
                 */
                const thread =
                    findThreadRoot(comment);

                if (!thread) {
                    return;
                }

                /*
                 * Don't process same thread twice.
                 */
                if (
                    thread.dataset.adoProcessed ===
                    "true"
                ) {
                    return;
                }

                /*
                 * Safety check.
                 */
                if (!thread.contains(comment)) {
                    return;
                }

                /*
                 * Find associated file diff.
                 */
                const diff =
                    findAssociatedDiff(thread);

                /*
                 * Find associated filename header.
                 */
                const header =
                    findAssociatedHeader(
                        thread,
                        diff
                    );

                /*
                 * Remember original display values.
                 */
                const threadDisplay =
                    thread.style.display;

                const headerDisplay =
                    header
                        ? header.style.display
                        : "";

                const diffDisplay =
                    diff
                        ? diff.style.display
                        : "";

                /*
                 * Create collapsed UI.
                 */
                const bar =
                    createCollapsedBar(
                        header
                    );

                /*
                 * Mark as processed BEFORE changing
                 * the DOM so MutationObserver does not
                 * process it repeatedly.
                 */
                thread.dataset.adoProcessed =
                    "true";

                /*
                 * Put collapsed bar before the thread.
                 */
                thread.parentElement?.insertBefore(
                    bar,
                    thread
                );

                /*
                 * Hide complete thread.
                 */
                thread.style.display =
                    "none";

                /*
                 * Hide file header.
                 */
                if (header) {
                    header.style.display =
                        "none";

                    header.dataset.adoCollapsed =
                        "true";
                }

                /*
                 * Hide diff.
                 */
                if (diff) {
                    diff.style.display =
                        "none";

                    diff.dataset.adoCollapsed =
                        "true";
                }

                thread.dataset.adoCollapsed =
                    "true";

                /*
                 * Expand button.
                 */
                const expandButton =
                    bar.querySelector(
                        ".ado-resolved-toggle"
                    );

                if (expandButton) {
                    expandButton.addEventListener(
                        "click",
                        () => {
                            expandThread(
                                thread,
                                header,
                                diff,
                                bar,
                                threadDisplay,
                                headerDisplay,
                                diffDisplay
                            );
                        }
                    );
                }
            });
    }

    /*
     * ------------------------------------------------------------
     * Azure DevOps SPA mutation handling.
     * ------------------------------------------------------------
     */
    let scheduled = false;

    function scheduleScan() {
        if (scheduled) {
            return;
        }

        scheduled = true;

        requestAnimationFrame(() => {
            scheduled = false;

            processThreads();
        });
    }

    /*
     * Initial scan.
     */
    processThreads();

    /*
     * Watch for Azure DevOps dynamically rendered content.
     */
    const observer =
        new MutationObserver(
            scheduleScan
        );

    observer.observe(
        document.body,
        {
            childList: true,
            subtree: true
        }
    );

})();
