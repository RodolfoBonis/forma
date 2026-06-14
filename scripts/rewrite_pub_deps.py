#!/usr/bin/env python3
"""Rewrite internal workspace dependencies to hosted references for publishing.

Used by the release workflow. For the pubspec.yaml given as the first argument,
every internal package dependency (e.g. `forma_foundation: ^2.0.0`) is replaced
with a hosted block so a published package resolves its siblings from the
private pub server instead of the workspace.

Packages are versioned independently (via `melos version`), so by default each
internal dependency keeps the exact constraint already written in the pubspec
(e.g. `^2.1.0`). For release-candidate publishes, the packages that are part of
the current release must instead point at each other's exact RC versions —
pass those via RC_PINS.

Environment:
  PUB_URL        hosted pub server URL (required)
  INTERNAL_PKGS  space-separated internal package names to rewrite (required)
  RC_PINS        optional, space-separated "name=version" pairs. For each listed
                 package the dependency is pinned to that exact version (no
                 caret), so RC packages resolve each other. Internal deps not
                 listed keep their existing caret constraint.
"""

from __future__ import annotations

import os
import re
import sys


def _parse_pins(raw: str) -> dict[str, str]:
    pins: dict[str, str] = {}
    for token in raw.split():
        if "=" in token:
            name, version = token.split("=", 1)
            pins[name] = version
    return pins


def rewrite(pubspec_path: str) -> None:
    url = os.environ["PUB_URL"]
    internal = os.environ["INTERNAL_PKGS"].split()
    pins = _parse_pins(os.environ.get("RC_PINS", ""))

    with open(pubspec_path, encoding="utf-8") as handle:
        content = handle.read()

    for name in internal:
        # Capture the existing constraint (e.g. "^2.1.0") so independent
        # versions are preserved unless this package is pinned for an RC.
        match = re.search(
            rf"^  {re.escape(name)}: (\S.*)$",
            content,
            flags=re.MULTILINE,
        )
        if not match:
            continue
        version = pins[name] if name in pins else match.group(1).strip()
        hosted = (
            f"  {name}:\n"
            f"    hosted:\n"
            f"      name: {name}\n"
            f"      url: {url}\n"
            f"    version: {version}"
        )
        content = re.sub(
            rf"^  {re.escape(name)}: \S.*$",
            hosted,
            content,
            flags=re.MULTILINE,
        )

    with open(pubspec_path, "w", encoding="utf-8") as handle:
        handle.write(content)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("usage: rewrite_pub_deps.py <pubspec.yaml>", file=sys.stderr)
        raise SystemExit(2)
    rewrite(sys.argv[1])
