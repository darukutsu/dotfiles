# ruff: noqa: F821
# ty: ignore[unresolved-reference]

## Background color of the completion widget category headers.
## Type: QssColor
# c.colors.completion.category.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #888888, stop:1 #505050)'
c.colors.completion.category.bg = "#3B4261"

## Bottom border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.bottom = "#1F2335"

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.top = "#1F2335"

## Foreground color of completion widget category headers.
## Type: QtColor
c.colors.completion.category.fg = "#00A0FF"

## Background color of the completion widget for even rows.
## Type: QssColor
c.colors.completion.even.bg = "#292E42"

## Text color of the completion widget. May be a single color to use for
## all columns or a list of three colors, one for each column.
## Type: List of QtColor, or QtColor
c.colors.completion.fg = ["#C0CAF5", "#C0CAF5", "#C0CAF5"]

## Background color of the selected completion item.
## Type: QssColor
# c.colors.completion.item.selected.bg = '#e8c000'
c.colors.completion.item.selected.bg = "#7AA2F7"

## Bottom border color of the selected completion item.
## Type: QssColor
# c.colors.completion.item.selected.border.bottom = '#bbbb00'

## Top border color of the selected completion item.
## Type: QssColor
# c.colors.completion.item.selected.border.top = '#bbbb00'

## Foreground color of the selected completion item.
## Type: QtColor
c.colors.completion.item.selected.fg = "black"

## Foreground color of the matched text in the selected completion item.
## Type: QtColor
# c.colors.completion.item.selected.match.fg = '#ff4444'

## Foreground color of the matched text in the completion.
## Type: QtColor
# c.colors.completion.match.fg = '#ff4444'

## Background color of the completion widget for odd rows.
## Type: QssColor
c.colors.completion.odd.bg = "#24283B"

## Color of the scrollbar in the completion view.
## Type: QssColor
c.colors.completion.scrollbar.bg = "#24283B"

## Color of the scrollbar handle in the completion view.
## Type: QssColor
c.colors.completion.scrollbar.fg = "white"

## Background color of disabled items in the context menu. If set to
## null, the Qt default is used.
## Type: QssColor
# c.colors.contextmenu.disabled.bg = None

## Foreground color of disabled items in the context menu. If set to
## null, the Qt default is used.
## Type: QssColor
# c.colors.contextmenu.disabled.fg = None

## Background color of the context menu. If set to null, the Qt default
## is used.
## Type: QssColor
# c.colors.contextmenu.menu.bg = None

## Foreground color of the context menu. If set to null, the Qt default
## is used.
## Type: QssColor
# c.colors.contextmenu.menu.fg = None

## Background color of the context menu's selected item. If set to null,
## the Qt default is used.
## Type: QssColor
# c.colors.contextmenu.selected.bg = None

## Foreground color of the context menu's selected item. If set to null,
## the Qt default is used.
## Type: QssColor
# c.colors.contextmenu.selected.fg = None

## Background color for the download bar.
## Type: QssColor
c.colors.downloads.bar.bg = "#24283B"

## Background color for downloads with errors.
## Type: QtColor
# c.colors.downloads.error.bg = 'red'

## Foreground color for downloads with errors.
## Type: QtColor
# c.colors.downloads.error.fg = 'white'

## Color gradient start for download backgrounds.
## Type: QtColor
# c.colors.downloads.start.bg = '#0000aa'

## Color gradient start for download text.
## Type: QtColor
# c.colors.downloads.start.fg = 'white'

## Color gradient stop for download backgrounds.
## Type: QtColor
# c.colors.downloads.stop.bg = '#00aa00'

## Color gradient end for download text.
## Type: QtColor
# c.colors.downloads.stop.fg = 'white'

## Color gradient interpolation system for download backgrounds.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.downloads.system.bg = 'rgb'

## Color gradient interpolation system for download text.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.downloads.system.fg = 'rgb'

## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
## Type: QssColor
# c.colors.hints.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 rgba(255, 247, 133, 0.8), stop:1 rgba(255, 197, 66, 0.8))'

## Font color for hints.
## Type: QssColor
# c.colors.hints.fg = 'black'

## Font color for the matched part of hints.
## Type: QtColor
# c.colors.hints.match.fg = 'green'

## Background color of the keyhint widget.
## Type: QssColor
# c.colors.keyhint.bg = 'rgba(24, 28, 3B, 80%)'

## Text color for the keyhint widget.
## Type: QssColor
c.colors.keyhint.fg = "#C0CAF5"

## Highlight color for keys to complete the current keychain.
## Type: QssColor
# c.colors.keyhint.suffix.fg = '#FFFF00'

## Background color of an error message.
## Type: QssColor
# c.colors.messages.error.bg = 'red'

## Border color of an error message.
## Type: QssColor
# c.colors.messages.error.border = '#bb0000'

## Foreground color of an error message.
## Type: QssColor
# c.colors.messages.error.fg = 'white'

## Background color of an info message.
## Type: QssColor
c.colors.messages.info.bg = "#24283B"

## Border color of an info message.
## Type: QssColor
# c.colors.messages.info.border = '#333333'

## Foreground color of an info message.
## Type: QssColor
# c.colors.messages.info.fg = 'white'

## Background color of a warning message.
## Type: QssColor
# c.colors.messages.warning.bg = 'darkorange'

## Border color of a warning message.
## Type: QssColor
# c.colors.messages.warning.border = '#d47300'

## Foreground color of a warning message.
## Type: QssColor
# c.colors.messages.warning.fg = 'black'

## Background color for prompts.
## Type: QssColor
c.colors.prompts.bg = "#24283B"

## Border used around UI elements in prompts.
## Type: String
# c.colors.prompts.border = '1px solid gray'

## Foreground color for prompts.
## Type: QssColor
c.colors.prompts.fg = "#C0CAF5"

## Background color for the selected item in filename prompts.
## Type: QssColor
# c.colors.prompts.selected.bg = 'grey'

## Foreground color for the selected item in filename prompts.
## Type: QssColor
# c.colors.prompts.selected.fg = 'white'

## Background color of the statusbar in caret mode.
## Type: QssColor
# c.colors.statusbar.caret.bg = 'purple'

## Foreground color of the statusbar in caret mode.
## Type: QssColor
# c.colors.statusbar.caret.fg = 'white'

## Background color of the statusbar in caret mode with a selection.
## Type: QssColor
# c.colors.statusbar.caret.selection.bg = '#a12dff'

## Foreground color of the statusbar in caret mode with a selection.
## Type: QssColor
# c.colors.statusbar.caret.selection.fg = 'white'

## Background color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.bg = "#CA1243"

## Foreground color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.fg = "#F3F3F3"

## Background color of the statusbar in private browsing + command mode.
## Type: QssColor
# c.colors.statusbar.command.private.bg = 'darkslategray'

## Foreground color of the statusbar in private browsing + command mode.
## Type: QssColor
# c.colors.statusbar.command.private.fg = 'white'

## Background color of the statusbar in insert mode.
## Type: QssColor
# c.colors.statusbar.insert.bg = 'darkgreen'

## Foreground color of the statusbar in insert mode.
## Type: QssColor
# c.colors.statusbar.insert.fg = 'white'

## Background color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.bg = "#24283B"

## Foreground color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.fg = "white"

## Background color of the statusbar in passthrough mode.
## Type: QssColor
# c.colors.statusbar.passthrough.bg = 'darkblue'

## Foreground color of the statusbar in passthrough mode.
## Type: QssColor
# c.colors.statusbar.passthrough.fg = 'white'

## Background color of the statusbar in private browsing mode.
## Type: QssColor
# c.colors.statusbar.private.bg = '#666666'

## Foreground color of the statusbar in private browsing mode.
## Type: QssColor
# c.colors.statusbar.private.fg = 'white'

## Background color of the progress bar.
## Type: QssColor
# c.colors.statusbar.progress.bg = 'white'

## Foreground color of the URL in the statusbar on error.
## Type: QssColor
# c.colors.statusbar.url.error.fg = 'orange'

## Default foreground color of the URL in the statusbar.
## Type: QssColor
c.colors.statusbar.url.fg = "#C0CAF5"

## Foreground color of the URL in the statusbar for hovered links.
## Type: QssColor
c.colors.statusbar.url.hover.fg = "lime"

## Foreground color of the URL in the statusbar on successful load
## (http).
## Type: QssColor
c.colors.statusbar.url.success.http.fg = "white"

## Foreground color of the URL in the statusbar on successful load
## (https).
## Type: QssColor
c.colors.statusbar.url.success.https.fg = "#00A0FF"

## Foreground color of the URL in the statusbar when there's a warning.
## Type: QssColor
# c.colors.statusbar.url.warn.fg = 'yellow'

## Background color of the tab bar.
## Type: QssColor
c.colors.tabs.bar.bg = "#24283B"

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = "#24283B"

## Foreground color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.fg = "#C0CAF5"

## Color for the tab indicator on errors.
## Type: QtColor
# c.colors.tabs.indicator.error = '#ff0000'

## Color gradient start for the tab indicator.
## Type: QtColor
# c.colors.tabs.indicator.start = '#0000aa'

## Color gradient end for the tab indicator.
## Type: QtColor
# c.colors.tabs.indicator.stop = '#00aa00'

## Color gradient interpolation system for the tab indicator.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.tabs.indicator.system = 'rgb'

## Background color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.bg = "#24283B"

## Foreground color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.fg = "#C0CAF5"

## Background color of pinned unselected even tabs.
## Type: QtColor
c.colors.tabs.pinned.even.bg = "#ff9000"

## Foreground color of pinned unselected even tabs.
## Type: QtColor
c.colors.tabs.pinned.even.fg = "#000000"

## Background color of pinned unselected odd tabs.
## Type: QtColor
c.colors.tabs.pinned.odd.bg = "#ff9000"

## Foreground color of pinned unselected odd tabs.
## Type: QtColor
c.colors.tabs.pinned.odd.fg = "#000000"

## Background color of pinned selected even tabs.
## Type: QtColor
c.colors.tabs.pinned.selected.even.bg = "#7AA2F7"

## Foreground color of pinned selected even tabs.
## Type: QtColor
c.colors.tabs.pinned.selected.even.fg = "#000000"

## Background color of pinned selected odd tabs.
## Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = "#7AA2F7"

## Foreground color of pinned selected odd tabs.
## Type: QtColor
c.colors.tabs.pinned.selected.odd.fg = "#000000"

## Background color of selected even tabs.
## Type: QtColor
c.colors.tabs.selected.even.bg = "#7AA2F7"

## Foreground color of selected even tabs.
## Type: QtColor
c.colors.tabs.selected.even.fg = "#000000"

## Background color of selected odd tabs.
## Type: QtColor
c.colors.tabs.selected.odd.bg = "#7AA2F7"

## Foreground color of selected odd tabs.
## Type: QtColor
c.colors.tabs.selected.odd.fg = "#000000"

## Background color for webpages if unset (or empty to use the theme's
## color).
## Type: QtColor
# c.colors.webpage.bg = 'white'

## Which algorithm to use for modifying how colors are rendered with
## darkmode. The `lightness-cielab` value was added with QtWebEngine 5.14
## and is treated like `lightness-hsl` with older QtWebEngine versions.
## Type: String
## Valid values:
##   - lightness-cielab: Modify colors by converting them to CIELAB color space and inverting the L value. Not available with Qt < 5.14.
##   - lightness-hsl: Modify colors by converting them to the HSL color space and inverting the lightness (i.e. the "L" in HSL).
##   - brightness-rgb: Modify colors by subtracting each of r, g, and b from their maximum value.
# c.colors.webpage.darkmode.algorithm = 'lightness-cielab'

## Contrast for dark mode. This only has an effect when
## `colors.webpage.darkmode.algorithm` is set to `lightness-hsl` or
## `brightness-rgb`.
## Type: Float
# c.colors.webpage.darkmode.contrast = 0.0

## Render all web contents using a dark theme. Example configurations
## from Chromium's `chrome://flags`:  - "With simple HSL/CIELAB/RGB-based
## inversion": Set   `colors.webpage.darkmode.algorithm` accordingly.  -
## "With selective image inversion": Set
## `colors.webpage.darkmode.policy.images` to `smart`.  - "With selective
## inversion of non-image elements": Set
## `colors.webpage.darkmode.threshold.text` to 150 and
## `colors.webpage.darkmode.threshold.background` to 205.  - "With
## selective inversion of everything": Combines the two variants   above.
## Type: Bool
# c.colors.webpage.darkmode.enabled = False

## Render all colors as grayscale. This only has an effect when
## `colors.webpage.darkmode.algorithm` is set to `lightness-hsl` or
## `brightness-rgb`.
## Type: Bool
# c.colors.webpage.darkmode.grayscale.all = False

## Desaturation factor for images in dark mode. If set to 0, images are
## left as-is. If set to 1, images are completely grayscale. Values
## between 0 and 1 desaturate the colors accordingly.
## Type: Float
# c.colors.webpage.darkmode.grayscale.images = 0.0

## Which images to apply dark mode to. With QtWebEngine 5.15.0, this
## setting can cause frequent renderer process crashes due to a
## https://codereview.qt-project.org/c/qt/qtwebengine-
## chromium/+/304211[bug in Qt].
## Type: String
## Valid values:
##   - always: Apply dark mode filter to all images.
##   - never: Never apply dark mode filter to any images.
##   - smart: Apply dark mode based on image content. Not available with Qt 5.15.0.
# c.colors.webpage.darkmode.policy.images = 'smart'

## Which pages to apply dark mode to. The underlying Chromium setting has
## been removed in QtWebEngine 5.15.3, thus this setting is ignored
## there. Instead, every element is now classified individually.
## Type: String
## Valid values:
##   - always: Apply dark mode filter to all frames, regardless of content.
##   - smart: Apply dark mode filter to frames based on background color.
# c.colors.webpage.darkmode.policy.page = 'smart'

## Threshold for inverting background elements with dark mode. Background
## elements with brightness above this threshold will be inverted, and
## below it will be left as in the original, non-dark-mode page. Set to
## 256 to never invert the color or to 0 to always invert it. Note: This
## behavior is the opposite of `colors.webpage.darkmode.threshold.text`!
## Type: Int
# c.colors.webpage.darkmode.threshold.background = 0

## Threshold for inverting text with dark mode. Text colors with
## brightness below this threshold will be inverted, and above it will be
## left as in the original, non-dark-mode page. Set to 256 to always
## invert text color or to 0 to never invert text color.
## Type: Int
# c.colors.webpage.darkmode.threshold.text = 256

## Value to use for `prefers-color-scheme:` for websites. The "light"
## value is only available with QtWebEngine 5.15.2+. On older versions,
## it is the same as "auto". The "auto" value is broken on QtWebEngine
## 5.15.2 due to a Qt bug. There, it will fall back to "light"
## unconditionally.
## Type: String
## Valid values:
##   - auto: Use the system-wide color scheme setting.
##   - light: Force a light theme.
##   - dark: Force a dark theme.
# c.colors.webpage.preferred_color_scheme = 'auto'
