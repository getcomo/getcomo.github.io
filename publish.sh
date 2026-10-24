#!/bin/bash
# Publishes site/ (only) from the release branch to GitHub Pages: getcomo.github.io (getcomo/getcomo.github.io),
# and the first address, matthewkim-11.github.io/como-site, which App Store listings still name. Branch main.
# Commit your site changes on `release` first. Rebuilds privacy.html from legal/PRIVACY.md before that.
#
#   node site/build-privacy.mjs && git commit -am "…"   # on release
#   site/publish.sh
set -euo pipefail
REPOS="${COMO_SITE_REPOS:-https://github.com/getcomo/getcomo.github.io.git https://github.com/matthewkim-11/como-site.git}"
cd "$(git rev-parse --show-toplevel)"
git subtree split --prefix site release -b site-publish >/dev/null
for repo in $REPOS; do git -c credential.helper= -c 'credential.helper=!gh auth git-credential' push "$repo" site-publish:main; done
git branch -D site-publish >/dev/null
echo "✓ published; GitHub Pages updates in about a minute"
