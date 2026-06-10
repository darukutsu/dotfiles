// ==UserScript==
// @name         ProtonDB Status Badge
// @namespace    https://github.com/your-namespace
// @version      2.0
// @description  Shows ProtonDB compatibility status on Steam game pages
// @author       you
// @match        https://store.steampowered.com/app/*
// @grant        GM_xmlhttpRequest
// @grant        GM.xmlHttpRequest
// @connect      protondb.com
// @connect      www.protondb.com
// ==/UserScript==

(function () {
	"use strict";

	const TIER_COLORS = {
		platinum: "#b4c7dc",
		gold: "#cfb44a",
		silver: "#a8a8a8",
		bronze: "#cd7f32",
		borked: "#e84c4c",
		pending: "#7f8c8d",
		native: "#59bf40",
	};

	const gmFetch =
		typeof GM !== "undefined" && GM.xmlHttpRequest
			? (d) => GM.xmlHttpRequest(d)
			: (d) => GM_xmlhttpRequest(d);

	function extractAppId() {
		const match = location.pathname.match(/\/app\/(\d+)/);
		return match ? match[1] : null;
	}

	function buildBadge(tier, appId) {
		const color = TIER_COLORS[tier] ?? "#7f8c8d";
		const label = tier.charAt(0).toUpperCase() + tier.slice(1);

		const wrapper = document.createElement("a");
		wrapper.href = `https://www.protondb.com/app/${appId}`;
		wrapper.target = "_blank";
		wrapper.rel = "noopener noreferrer";

		wrapper.style.cssText = `
            display: inline-flex;
            align-items: center;
            gap: 6px;
            height: 30px;
            padding: 0 10px;
            margin-right: 6px;
            border-radius: 2px;
            text-decoration: none;

            background: linear-gradient(to bottom,
                rgba(93, 123, 150, 0.72),
                rgba(66, 92, 117, 0.72)
            );

            border: 1px solid rgba(255,255,255,0.06);

            box-shadow:
                inset 0 1px 0 rgba(255,255,255,0.05),
                inset 0 -1px 0 rgba(0,0,0,0.25);

            transition: filter 120ms ease;

            font-family: "Motiva Sans", Arial, Helvetica, sans-serif;
        `;

		wrapper.addEventListener("mouseenter", () => {
			wrapper.style.filter = "brightness(1.12)";
		});

		wrapper.addEventListener("mouseleave", () => {
			wrapper.style.filter = "brightness(1)";
		});

		const icon = document.createElement("div");
		icon.textContent = "🛡";
		icon.style.cssText = `
            font-size: 14px;
            line-height: 1;
            filter: saturate(0.9);
        `;

		const text = document.createElement("div");
		text.style.cssText = `
            display: flex;
            align-items: center;
            gap: 6px;
            line-height: 1;
        `;

		const title = document.createElement("span");
		title.textContent = "ProtonDB";
		title.style.cssText = `
            color: #d6e3f0;
            font-size: 13px;
            font-weight: 500;
        `;

		const pill = document.createElement("span");
		pill.textContent = label;
		pill.style.cssText = `
            color: ${color};
            background: rgba(255,255,255,0.06);
            border: 1px solid rgba(255,255,255,0.12);

            padding: 1px 6px;
            border-radius: 2px;

            font-size: 10px;
            font-weight: 700;

            text-transform: uppercase;
            letter-spacing: 0.06em;
        `;

		text.append(title, pill);
		wrapper.append(icon, text);

		return wrapper;
	}

	function injectBadge(badge) {
		// Standard Steam top-right button container
		const topRightRow = document.querySelector(".apphub_OtherSiteInfo");

		if (topRightRow) {
			topRightRow.prepend(badge);
			return;
		}

		// Some Steam pages only have Community Hub button
		const communityBtn = document.querySelector(
			".apphub_OtherSiteInfo a, .apphub_AppName + div a.btnv6_blue_hoverfade",
		);

		if (communityBtn && communityBtn.parentElement) {
			communityBtn.parentElement.insertBefore(badge, communityBtn);
			return;
		}

		// Fallback near title
		const title = document.querySelector("#appHubAppName");

		if (title) {
			const row = document.createElement("div");
			row.style.cssText = `
                display:flex;
                align-items:center;
                gap:6px;
                margin-top:6px;
            `;

			title.insertAdjacentElement("afterend", row);
			row.appendChild(badge);
			return;
		}

		// Last resort retry for dynamically loaded Steam pages
		setTimeout(() => injectBadge(badge), 1000);
	}

	function fetchProtonStatus(appId) {
		const url = `https://www.protondb.com/api/v1/reports/summaries/${appId}.json`;

		console.log("[ProtonDB] requesting:", url);

		gmFetch({
			method: "GET",
			url,
			anonymous: true,
			headers: {
				Accept: "application/json",
				Origin: "https://www.protondb.com",
				Referer: "https://www.protondb.com/",
				"User-Agent": navigator.userAgent,
			},
			overrideMimeType: "application/json",

			onload(response) {
				console.log("[ProtonDB] response:", response.status);

				if (response.status !== 200 || !response.responseText) {
					console.log("[ProtonDB] invalid response");
					injectBadge(buildBadge("pending", appId));
					return;
				}

				try {
					const raw = response.responseText;
					const data = JSON.parse(raw);

					console.log("[ProtonDB] parsed:", data);

					let tier =
						data.trendingTier ||
						data.tier ||
						data.bestReportedTier ||
						data.confidence ||
						"pending";

					tier = String(tier).toLowerCase();

					// Greasemonkey occasionally returns empty object
					// but embeds response text correctly
					if (!tier || tier === "undefined") {
						const match = raw.match(/"tier":"(.*?)"/i);
						if (match) {
							tier = match[1].toLowerCase();
						}
					}

					injectBadge(buildBadge(tier, appId));
				} catch (e) {
					console.log("[ProtonDB] parse failure:", e);
					injectBadge(buildBadge("pending", appId));
				}
			},

			ontimeout() {
				console.log("[ProtonDB] timeout");
				injectBadge(buildBadge("pending", appId));
			},

			onerror(error) {
				console.log("[ProtonDB] network error:", error);

				// fallback through public proxy for Greasemonkey
				gmFetch({
					method: "GET",
					url: `https://cors.isomorphic-git.org/${url}`,
					anonymous: true,
					onload(proxyResponse) {
						try {
							const data = JSON.parse(proxyResponse.responseText);
							const tier = (
								data.trendingTier ||
								data.tier ||
								data.bestReportedTier ||
								"pending"
							).toLowerCase();

							injectBadge(buildBadge(tier, appId));
						} catch {
							injectBadge(buildBadge("pending", appId));
						}
					},
					onerror() {
						injectBadge(buildBadge("pending", appId));
					},
				});
			},
		});
	}

	const appId = extractAppId();

	if (appId) {
		// Steam sometimes renders header late
		window.addEventListener("load", () => {
			setTimeout(() => {
				fetchProtonStatus(appId);
			}, 500);
		});
	}
})();
