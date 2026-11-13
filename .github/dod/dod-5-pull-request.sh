#!/usr/bin/env bash
# DoD 5 · Pull Request
#   Erfüllt, wenn der zuletzt gemergte Pull Request von dev nach main
#   erst gemergt wurde, NACHDEM der Test "Compose-Stack testen (Port 8085)"
#   für seinen letzten Commit grün war.
# Fragt nur die GitHub-API ab (gespeicherte Check-Ergebnisse), braucht keinen Checkout-Inhalt.
set -uo pipefail
source "$(dirname "$0")/gemeinsam.sh"
CHECK_NAME="Compose-Stack testen (Port 8085)"

steckbrief_start "DoD 5 · Pull Request"

if ! PRS=$(api "repos/${GITHUB_REPOSITORY}/pulls?state=closed&base=main&per_page=100"); then
  fehlt "GitHub-API" "Die Pull Requests konnten nicht abgefragt werden."
  ende
fi

PR=$(jq -c '[.[] | select(.merged_at != null and .head.ref == "dev")]
            | sort_by(.merged_at) | last // empty' <<<"$PRS")
if [ -z "$PR" ]; then
  OFFEN=$(api "repos/${GITHUB_REPOSITORY}/pulls?state=open&base=main&head=${GITHUB_REPOSITORY%%/*}:dev" | jq -r '.[0].number // empty')
  if [ -n "$OFFEN" ]; then
    fehlt "Pull Request noch nicht gemergt" "Pull Request #$OFFEN von dev nach main ist offen. Warte auf den grünen Check und merge dann (Phase 6)."
  else
    fehlt "Kein gemergter Pull Request" "Es wurde noch kein Pull Request von dev nach main gemergt (Phase 6)."
  fi
  ende
fi

NR=$(jq -r '.number' <<<"$PR")
SHA=$(jq -r '.head.sha' <<<"$PR")
GEMERGT_UM=$(jq -r '.merged_at' <<<"$PR")
ok "Pull Request gemergt" "#$NR (dev → main) am $GEMERGT_UM"

NAME_URI=$(jq -rn --arg s "$CHECK_NAME" '$s|@uri')
if ! CHECKS=$(api "repos/${GITHUB_REPOSITORY}/commits/${SHA}/check-runs?check_name=${NAME_URI}&per_page=100"); then
  fehlt "GitHub-API" "Die Check-Ergebnisse konnten nicht abgefragt werden."
  ende
fi
GRUEN_VORHER=$(jq -r --arg m "$GEMERGT_UM" '
  [.check_runs[] | select(.conclusion == "success" and .completed_at != null and .completed_at <= $m)]
  | length' <<<"$CHECKS")

if [ "${GRUEN_VORHER:-0}" -ge 1 ]; then
  ok "Test vor dem Merge grün" "„$CHECK_NAME“ für Commit ${SHA:0:7}"
else
  fehlt "Merge vor grünem Test" "Pull Request #$NR wurde gemergt, ohne dass „$CHECK_NAME“ für seinen letzten Commit ${SHA:0:7} vorher grün war. Korrigiere auf dev, stelle einen neuen Pull Request und merge erst nach grünem Check."
fi

ende
