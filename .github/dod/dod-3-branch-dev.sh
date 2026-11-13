#!/usr/bin/env bash
# DoD 3 · Branch dev
#   Erfüllt, wenn
#     - der Branch dev existiert UND mindestens einen eigenen Commit gegenüber main hat,
#   oder
#     - bereits ein Pull Request von dev nach main gemergt wurde
#       (dann darf dev auch gelöscht oder wieder gleich main sein).
# Fragt nur die GitHub-API ab, braucht keinen Checkout-Inhalt.
set -uo pipefail
source "$(dirname "$0")/gemeinsam.sh"

steckbrief_start "DoD 3 · Branch dev"

GEMERGT=""
if PRS=$(api "repos/${GITHUB_REPOSITORY}/pulls?state=closed&base=main&per_page=100"); then
  GEMERGT=$(jq -r '[.[] | select(.merged_at != null and .head.ref == "dev")]
                   | sort_by(.merged_at) | last | .number // empty' <<<"$PRS")
fi

if api "repos/${GITHUB_REPOSITORY}/branches/dev" > /dev/null 2>&1; then
  ok "Branch dev existiert"
  VORAUS=$(api "repos/${GITHUB_REPOSITORY}/compare/main...dev" | jq -r '.ahead_by // 0')
  if [ "${VORAUS:-0}" -ge 1 ]; then
    ok "Eigene Änderungen auf dev" "$VORAUS Commit(s) gegenüber main"
  elif [ -n "$GEMERGT" ]; then
    ok "Eigene Änderungen auf dev" "bereits per Pull Request #$GEMERGT nach main gemergt"
  else
    fehlt "Keine eigene Änderung auf dev" "Der Branch dev ist identisch mit main. Committe deine Umstellung auf Apache auf dev und pushe (Phase 5)."
  fi
elif [ -n "$GEMERGT" ]; then
  ok "Branch dev existierte" "per Pull Request #$GEMERGT nach main gemergt und danach gelöscht"
else
  fehlt "Kein Branch dev" "Es gibt noch keinen Branch dev auf GitHub. Lege ihn an und pushe ihn: git switch -c dev, dann git push -u origin dev (Phase 5)."
fi

ende
