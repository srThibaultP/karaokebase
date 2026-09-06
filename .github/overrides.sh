#!/usr/bin/env bash
# Local overrides applied on top of upstream kara.moe/karaokebase.
#
# WHY: kmexplorer's isPlayable() blocks in-browser playback for a non-admin
# visitor as soon as any of a kara's tags carries "noLiveDownload": true.
# Upstream sets that flag on the Asia / West / Non-Latin *collections* (licensing
# on kara.moe's own public site). On this instance we want the public to be able
# to watch anything that has a hardsub, so we clear the flag on those three
# collection tags. Everything else (Unavailable, Boku no Pico, +eRa+, ...) is
# left untouched.
#
# Idempotent: safe to run repeatedly. Re-run by the sync-upstream workflow after
# every merge from upstream.
set -euo pipefail
cd "$(dirname "$0")/.."

OVERRIDES=(
  "tags/Asia.dbcf2c22.tag.json"       # collection "Asia"
  "tags/West.efe171c0.tag.json"       # collection "West"
  "tags/Non-Latin.f2462778.tag.json"  # collection "Non-Latin"
)

for f in "${OVERRIDES[@]}"; do
  if [ -f "$f" ]; then
    perl -pi -e 's/("noLiveDownload"\s*:\s*)true/${1}false/' "$f"
  else
    echo "note: $f not present upstream anymore, skipping" >&2
  fi
done
