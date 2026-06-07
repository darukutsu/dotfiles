// vibecoded
(function () {
	const selection = window.getSelection();
	if (!selection || selection.isCollapsed) return;

	const range = selection.getRangeAt(0);
	const selected = selection.toString().trim();
	const words = selected.split(/\s+/);

	let fragment;
	if (words.length > 6) {
		const start = encodeURIComponent(words.slice(0, 3).join(" "));
		const end = encodeURIComponent(words.slice(-3).join(" "));
		fragment = start + "," + end;
	} else {
		const preRange = document.createRange();
		preRange.setStart(
			range.startContainer,
			Math.max(0, range.startOffset - 30),
		);
		preRange.setEnd(range.startContainer, range.startOffset);
		const prefix = preRange.toString().trim().split(/\s+/).pop() || "";

		const endOffset = Math.min(
			range.endContainer.textContent.length,
			range.endOffset + 30,
		);
		const sufRange = document.createRange();
		sufRange.setStart(range.endContainer, range.endOffset);
		sufRange.setEnd(range.endContainer, endOffset);
		const suffix = sufRange.toString().trim().split(/\s+/).shift() || "";

		fragment = prefix ? encodeURIComponent(prefix) + "-," : "";
		fragment += encodeURIComponent(selected);
		fragment += suffix ? ",-" + encodeURIComponent(suffix) : "";
	}

	const url = window.location.href.split("#")[0] + "#:~:text=" + fragment;
	navigator.clipboard.writeText(url);
})();
