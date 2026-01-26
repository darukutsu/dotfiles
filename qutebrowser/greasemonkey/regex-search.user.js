// ==UserScript==
// @name         Regex Search
// @namespace    http://tampermonkey.net/
// @version      5.0
// @description  Search current page using regex (Ctrl+R)
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function () {
	"use strict";

	let highlights = [];
	let currentIndex = -1;
	let searchBox = null;

	function removeHighlights() {
		highlights.forEach((info) => {
			const parent = info.span.parentNode;
			if (parent) {
				parent.replaceChild(
					document.createTextNode(info.span.textContent),
					info.span,
				);
				parent.normalize();
			}
		});
		highlights = [];
		currentIndex = -1;
	}

	function makeSelectionsSelectable() {
		if (
			highlights.length > 0 &&
			currentIndex >= 0 &&
			currentIndex < highlights.length
		) {
			highlights.forEach((h) => {
				h.span.style.backgroundColor = "transparent";
			});

			const range = document.createRange();
			range.selectNodeContents(highlights[currentIndex].span);

			const selection = window.getSelection();
			selection.removeAllRanges();
			selection.addRange(range);
		}
	}

	function highlightMatches(pattern) {
		removeHighlights();

		let regex;
		try {
			regex = new RegExp(pattern, "gi");
		} catch (e) {
			console.error("Invalid regex:", e);
			return;
		}

		const skipTags = new Set([
			"SCRIPT",
			"STYLE",
			"NOSCRIPT",
			"IFRAME",
			"INPUT",
			"TEXTAREA",
			"SELECT",
			"BUTTON",
		]);

		function processElement(element) {
			if (skipTags.has(element.nodeName)) return;
			if (element.classList?.contains("regex-search-ui")) return;

			for (let i = 0; i < element.childNodes.length; i++) {
				const node = element.childNodes[i];

				if (node.nodeType === Node.TEXT_NODE) {
					const text = node.textContent;
					if (!text.trim()) continue;

					const matches = [];
					let match;
					regex.lastIndex = 0;

					while ((match = regex.exec(text)) !== null) {
						matches.push({
							text: match[0],
							index: match.index,
						});
						if (match[0].length === 0) {
							regex.lastIndex++;
						}
					}

					if (matches.length > 0) {
						const frag = document.createDocumentFragment();
						let lastIndex = 0;

						matches.forEach((match) => {
							if (match.index > lastIndex) {
								frag.appendChild(
									document.createTextNode(
										text.substring(lastIndex, match.index),
									),
								);
							}

							const span = document.createElement("span");
							span.style.cssText =
								"background-color: yellow !important; display: inline !important;";
							span.textContent = match.text;
							span.className = "regex-highlight";
							frag.appendChild(span);

							highlights.push({ span });

							lastIndex = match.index + match.text.length;
						});

						if (lastIndex < text.length) {
							frag.appendChild(
								document.createTextNode(text.substring(lastIndex)),
							);
						}

						node.parentNode.replaceChild(frag, node);
						i += matches.length;
					}
				} else if (node.nodeType === Node.ELEMENT_NODE) {
					processElement(node);
				}
			}
		}

		processElement(document.body);

		if (highlights.length > 0) {
			currentIndex = 0;
			selectCurrent();
		}
		updateCounter();
	}

	function selectCurrent() {
		if (currentIndex >= 0 && currentIndex < highlights.length) {
			highlights.forEach((h, idx) => {
				if (idx === currentIndex) {
					h.span.style.backgroundColor = "orange";
				} else {
					h.span.style.backgroundColor = "yellow";
				}
			});

			highlights[currentIndex].span.scrollIntoView({
				behavior: "smooth",
				block: "center",
			});
		}
	}

	function updateCounter() {
		if (searchBox) {
			const counter = searchBox.querySelector(".match-counter");
			if (counter) {
				counter.textContent =
					matches.length > 0
						? `${currentIndex + 1}/${highlights.length}`
						: `0/${highlights.length}`;
			}
		}
	}

	function nextMatch() {
		if (highlights.length > 0) {
			currentIndex = (currentIndex + 1) % highlights.length;
			selectCurrent();
			updateCounter();
		}
	}

	function prevMatch() {
		if (highlights.length > 0) {
			currentIndex = (currentIndex - 1 + highlights.length) % highlights.length;
			selectCurrent();
			updateCounter();
		}
	}

	function createSearchBox() {
		const container = document.createElement("div");
		container.className = "regex-search-ui";
		container.style.cssText = `
            position: fixed;
            top: 10px;
            right: 10px;
            background: white;
            border: 2px solid #333;
            padding: 10px;
            z-index: 999999;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            font-family: monospace;
        `;

		const input = document.createElement("input");
		input.type = "text";
		input.placeholder = "Regex pattern...";
		input.style.cssText = "width: 250px; margin-right: 5px; padding: 5px;";

		const counter = document.createElement("span");
		counter.className = "match-counter";
		counter.textContent = "0/0";
		counter.style.cssText = "margin: 0 10px;";

		const closeBtn = document.createElement("button");
		closeBtn.textContent = "X";
		closeBtn.style.cssText = "margin-left: 5px; cursor: pointer;";

		container.appendChild(input);
		container.appendChild(counter);
		container.appendChild(closeBtn);

		let typingTimer;
		input.addEventListener("input", (e) => {
			clearTimeout(typingTimer);

			if (!e.target.value) {
				removeHighlights();
				updateCounter();
				input.style.backgroundColor = "white";
				return;
			}

			try {
				new RegExp(e.target.value);
				input.style.backgroundColor = "white";

				typingTimer = setTimeout(() => {
					highlightMatches(e.target.value);
				}, 300);
			} catch (err) {
				input.style.backgroundColor = "#ffcccc";
				removeHighlights();
				updateCounter();
			}
		});

		input.addEventListener("keydown", (e) => {
			if (e.key === "Enter") {
				clearTimeout(typingTimer);
				if (e.shiftKey) {
					prevMatch();
				} else {
					nextMatch();
				}
				e.preventDefault();
			} else if (e.key === "Escape") {
				closeSearchBox();
				e.stopPropagation();
			}
		});

		closeBtn.addEventListener("click", closeSearchBox);

		return container;
	}

	function closeSearchBox() {
		if (searchBox) {
			document.body.removeChild(searchBox);
			searchBox = null;
			makeSelectionsSelectable();
		}
	}

	function toggleSearchBox() {
		if (searchBox) {
			closeSearchBox();
		} else {
			removeHighlights();
			searchBox = createSearchBox();
			document.body.appendChild(searchBox);
			searchBox.querySelector("input").focus();
		}
	}

	document.addEventListener("keydown", (e) => {
		if (e.ctrlKey && e.key === "r") {
			e.preventDefault();
			toggleSearchBox();
		} else if (e.ctrlKey && (e.key === "g" || e.key === "G")) {
			e.preventDefault();
			if (e.shiftKey) {
				prevMatch();
			} else {
				nextMatch();
			}
		} else if (e.key === "Escape" && searchBox) {
			e.preventDefault();
			closeSearchBox();
		}
	});
})();
