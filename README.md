# Nova Lock

A drop-in replacement lock screen for the [Omarchy](https://omarchy.org/) Quickshell shell.

Split two-tone clock, profile picture, and a pill password field with per-character
dots. Every colour is read from Omarchy's `Color` singleton, so the lock face follows
whatever theme `omarchy theme set` last applied.

## Install

```bash
omarchy plugin disable omarchy.lock
omarchy plugin add https://github.com/dkgamer02ai/nova-lock.git --enable
```

Disable the stock lock first: both plugins register the same `lock` IPC target, and
the second one to register is ignored, so `omarchy system lock` would still reach
whichever won the race.

## Preview without locking

```bash
omarchy-shell lock preview      # click anywhere to dismiss
omarchy-shell lock hidePreview
```

## Profile picture

Drop a square image at `~/.face`. Without one, a glyph placeholder is drawn instead.

## Update

```bash
omarchy plugin update io.github.dkgamer02ai.lock
omarchy restart shell
```

A restart is required after any change to the plugin's QML: `rescanPlugins` picks up
new plugins but does not drop Quickshell's cache of already-loaded QML.

## Uninstall

```bash
omarchy plugin remove io.github.dkgamer02ai.lock
omarchy plugin enable omarchy.lock
```

## Notes

`Service.qml` is Omarchy's stock lock service, unchanged: PAM password and fingerprint
flows, `WlSessionLock`, idle blanking and the `lock` IPC handler all behave exactly as
they do on stock. Only `LockView.qml` — the presentation layer — is this project's.
That also means it tracks upstream: if Omarchy changes the service, re-copy
`/usr/share/omarchy/shell/plugins/lock/Service.qml` over this one.

Tunable knobs live at the top of `LockView.qml`: `clockFontSize`, `centerWidth`,
`avatarSize`, `fieldHeight`, `dotSize`.

## Licence

MIT
