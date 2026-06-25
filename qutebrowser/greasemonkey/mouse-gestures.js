// ==UserScript==
// @name         Mouse Gestures
// @namespace    qutebrowser-gestures
// @match        *://*/*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(function () {
  'use strict';

  const THRESHOLD = 30;      // px before a direction is registered
  const VISUAL    = true;    // show gesture trail overlay

  let startX, startY, lastX, lastY;
  let dirs = [];
  let lastDir = null;
  let active = false;
  let linkTarget = null;

  // rocker state
  let leftDown  = false;
  let rightDown = false;
  let rockerFired = false;

  // --- visual trail ---
  let canvas, ctx;

  function initCanvas() {
    canvas = document.createElement('canvas');
    Object.assign(canvas.style, {
      position:      'fixed',
      top:           '0',
      left:          '0',
      width:         '100vw',
      height:        '100vh',
      pointerEvents: 'none',
      zIndex:        '2147483647',
    });
    canvas.width  = window.innerWidth;
    canvas.height = window.innerHeight;
    ctx = canvas.getContext('2d');
    document.documentElement.appendChild(canvas);
  }

  function destroyCanvas() {
    if (canvas) { canvas.remove(); canvas = null; ctx = null; }
  }

  // --- gesture label overlay ---
  let label;

  function showLabel(text) {
    if (!VISUAL) return;
    if (!label) {
      label = document.createElement('div');
      Object.assign(label.style, {
        position:        'fixed',
        bottom:          '40px',
        left:            '50%',
        transform:       'translateX(-50%)',
        background:      'rgba(0,0,0,0.65)',
        color:           '#fff',
        padding:         '6px 16px',
        borderRadius:    '6px',
        fontSize:        '14px',
        fontFamily:      'monospace',
        pointerEvents:   'none',
        zIndex:          '2147483647',
        transition:      'opacity 0.1s',
      });
      document.documentElement.appendChild(label);
    }
    label.textContent = text;
    label.style.opacity = '1';
  }

  function hideLabel() {
    if (label) { label.style.opacity = '0'; }
  }

  // --- direction helpers ---
  function toDir(dx, dy) {
    if (Math.abs(dx) > Math.abs(dy)) return dx > 0 ? 'R' : 'L';
    return dy > 0 ? 'D' : 'U';
  }

  const GESTURE_NAMES = {
    'L':  '← Back',
    'R':  '→ Forward',
    'D':  '↓ New Tab',
    'UD': '↑↓ Reload',
    'DR': '↓→ Close Tab',
    // link gestures
    'D_link':  '↓ Open Link (fg)',
    'DU_link': '↓↑ Open Link (bg)',
  };

  function gestureKey(d, onLink) {
    const k = d.join('');
    return onLink ? k + '_link' : k;
  }

  // --- execute ---
  function execute(d, onLink, href) {
    const key = gestureKey(d, onLink && href);

    if (onLink && href) {
      if (key === 'D_link')  { location.href = href; return; }  // fg: navigate current tab
      if (key === 'DU_link') {
        const w = window.open(href, '_blank');
        if (w) { w.blur(); window.focus(); }  // bg: open and return focus here
        return;
      }
    }

    switch (d.join('')) {
      case 'L':  history.back();    break;
      case 'R':  history.forward(); break;
      case 'D':  window.open('https://www.google.com', '_blank'); break;
      case 'UD': location.reload(); break;
      case 'DR': window.close();    break;
    }
  }

  // --- event handlers ---
  document.addEventListener('mousedown', function (e) {
    if (e.button === 0) { leftDown  = true; rockerFired = false; }
    if (e.button === 2) { rightDown = true; rockerFired = false; }

    // rocker: left held, right clicked
    if (e.button === 2 && leftDown && !rockerFired) {
      rockerFired = true;
      e.preventDefault();
      history.forward();
      return;
    }
    // rocker: right held, left clicked
    if (e.button === 0 && rightDown && !rockerFired) {
      rockerFired = true;
      e.preventDefault();
      history.back();
      return;
    }

    if (e.button !== 2) return;

    startX = lastX = e.clientX;
    startY = lastY = e.clientY;
    dirs = [];
    lastDir = null;
    active = true;

    // detect if gesture starts on a link
    let el = e.target;
    linkTarget = null;
    while (el && el !== document.body) {
      if (el.tagName === 'A' && el.href) { linkTarget = el.href; break; }
      el = el.parentElement;
    }

    if (VISUAL) {
      initCanvas();
      ctx.strokeStyle = 'rgba(255, 80, 80, 0.85)';
      ctx.lineWidth   = 3;
      ctx.lineCap     = 'round';
      ctx.beginPath();
      ctx.moveTo(startX, startY);
    }
  }, true);

  document.addEventListener('mousemove', function (e) {
    if (!active) return;

    const dx = e.clientX - lastX;
    const dy = e.clientY - lastY;

    if (VISUAL && ctx) {
      ctx.lineTo(e.clientX, e.clientY);
      ctx.stroke();
      ctx.beginPath();
      ctx.moveTo(e.clientX, e.clientY);
    }

    if (Math.hypot(dx, dy) > THRESHOLD) {
      const dir = toDir(dx, dy);
      if (dir !== lastDir) {
        dirs.push(dir);
        lastDir = dir;
      }
      lastX = e.clientX;
      lastY = e.clientY;

      const key  = gestureKey(dirs, linkTarget && !!linkTarget);
      const name = GESTURE_NAMES[key] || GESTURE_NAMES[dirs.join('')] || dirs.join('');
      showLabel(name);
    }
  }, true);

  document.addEventListener('mouseup', function (e) {
    if (e.button === 0) leftDown = false;
    if (e.button === 2) {
      rightDown = false;
      if (!active) return;
      active = false;
      destroyCanvas();
      hideLabel();

      const totalDist = Math.hypot(e.clientX - startX, e.clientY - startY);
      if (dirs.length > 0 && totalDist > THRESHOLD) {
        e.preventDefault();
        e.stopPropagation();
        execute(dirs, !!linkTarget, linkTarget);
      }
      dirs = [];
      linkTarget = null;
    }
  }, true);

  // suppress context menu only after a real gesture
  document.addEventListener('contextmenu', function (e) {
    if (rockerFired) {
      e.preventDefault();
      e.stopPropagation();
      rockerFired = false;
      return;
    }
    const totalDist = Math.hypot(
      (e.clientX || 0) - (startX || 0),
      (e.clientY || 0) - (startY || 0)
    );
    if (totalDist > THRESHOLD) {
      e.preventDefault();
      e.stopPropagation();
    }
  }, true);

})();
