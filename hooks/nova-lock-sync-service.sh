#!/bin/bash

# Keep Nova Lock's copy of the stock lock service in step with Omarchy.
#
# The plugin deliberately ships Omarchy's lock Service.qml verbatim so the PAM
# and session-lock paths are the upstream ones, not a reimplementation. Plugin
# folders cannot symlink to it (omarchy-plugin-validate rejects symlinks), so
# the file is a copy — and a copy goes stale the moment upstream patches it.
# This runs after `omarchy update` and re-copies when they differ.
#
# The copy lands in the plugin's git worktree, so the change shows up as a
# normal diff for review and commit rather than being applied silently.

set -euo pipefail

STOCK=/usr/share/omarchy/shell/plugins/lock/Service.qml
PLUGIN="$HOME/.config/omarchy/plugins/io.github.dkgamer02ai.lock/Service.qml"

[[ -f $STOCK && -f $PLUGIN ]] || exit 0
cmp -s "$STOCK" "$PLUGIN" && exit 0

cp -- "$STOCK" "$PLUGIN"

omarchy-notification-send -g 󰌾 \
  "Nova Lock" \
  "Upstream lock service changed; Service.qml re-synced. Review the diff and restart the shell." 2>/dev/null || true
