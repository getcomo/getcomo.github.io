#!/bin/bash
# Publishes site/ (only) from the release branch to GitHub Pages: matthewkim-11/como-site, branch main.
# Commit your site changes on `release` first. Rebuilds privacy.html from legal/PRIVACY.md before that.
#
#   node site/build-privacy.mjs && git commit -am "…"   # on release
#   site/publish.sh
set -euo pipefail
REPO="${COMO_SITE_REPO:-https://github.com/matthewkim-11/como-site.git}"
cd "$(git rev-parse --show-toplevel)"
git subtree split --prefix site release -b site-publish >/dev/null
git -c credential.helper= -c 'credential.helper=!gh auth git-credential' push "$REPO" site-publish:main
git branch -D site-publish >/dev/null
echo "✓ published; GitHub Pages updates in about a minute"
