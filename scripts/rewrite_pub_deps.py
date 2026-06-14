#!/usr/bin/env python3
"""Rewrite internal workspace dependencies to hosted references for publishing.

Used by the release workflow. For the pubspec.yaml given as the first argument,
every internal package dependency (e.g. `forma_foundation: ^1.2.0`) is replaced
with a hosted block pinned at the release version, so a published package
resolves its siblings from the private pub server instead of the workspace.

Environment:
  NEW_VERSION    release version, e.g. "2.0.0"
  PUB_URL        hosted pub server URL
  INTERNAL_PKGS  space-separated internal package names to rewrite
"""

from __future__ import annotations

import os
import re
import sys


def rewrite(pubspec_path: str) -> None:
    version = os.environ["NEW_VERSION"]
    url = os.environ["PUB_URL"]
    internal = os.environ["INTERNAL_PKGS"].split()

    with open(pubspec_path, encoding="utf-8") as handle:
        content = handle.read()

    for name in internal:
        hosted = (
            f"  {name}:\n"
            f"    hosted:\n"
            f"      name: {name}\n"
            f"      url: {url}\n"
            f"    version: ^{version}"
        )
        content = re.sub(
            rf"^  {re.escape(name)}: \^.*$",
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
