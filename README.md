# Nova Lock

A drop-in replacement lock screen for the [Omarchy](https://omarchy.org/) Quickshell shell.

Split two-tone clock, profile picture, and a pill password field with per-character
dots. Every colour is read from Omarchy's `Color` singleton, so the lock face follows
whatever theme `omarchy theme set` last applied.

## Install

```bash
git clone https://github.com/dkgamer02ai/nova-lock \
  ~/.config/omarchy/plugins/io.github.dkgamer02ai.lock

omarchy-shell shell rescanPlugins
omarchy plugin disable omarchy.lock
omarchy plugin enable io.github.dkgamer02ai.lock
```

Both plugins register the same `lock` IPC target, so the stock one must be disabled —
otherwise `omarchy system lock` has two listeners.

## Preview without locking

```bash
omarchy-shell lock preview      # click anywhere to dismiss
omarchy-shell lock hidePreview
```

## Profile picture

Drop a square image at `~/.face`. Without one, a glyph placeholder is drawn instead.

## Uninstall

```bash
omarchy plugin disable io.github.dkgamer02ai.lock
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
