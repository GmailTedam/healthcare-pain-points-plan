#!/usr/bin/env bash
# Distribute Phase A bundles from this plans repo into each target repo's
# plans/healthcare-pain-points/ directory. Idempotent. Backs up any pre-existing
# bundle file to versions/v{N}/ in the target repo before overwrite
# (per feedback_version_before_overwrite).
#
# Usage:
#   ./scripts/distribute-bundles.sh                # apply
#   ./scripts/distribute-bundles.sh --dry-run      # preview
#
# Run from the root of the healthcare-pain-points-plan repo OR pass PLANS_DIR=...

set -euo pipefail

PLANS_DIR="${PLANS_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
WS="${WS:-$HOME/health-agent-workspace}"
BT="${BT:-$HOME/bt/BulletTrain}"
DRY=0
[[ "${1:-}" == "--dry-run" ]] && DRY=1

# bundle_dir_in_plans_repo  →  target_repo_root  (target_subdir is always plans/healthcare-pain-points/)
declare -a MAP=(
  "global-agent-registry|$WS/global-agent-registry"
  "Nexus-A2A-protocol|$WS/Nexus-A2A-protocol"
  "REA-Agent-mcp|$WS/REA-Agent-mcp"
  "caid-agent|$WS/caid-agent"
  "prompt-engine|$WS/prompt-engine"
  "clinical-pathways|$WS/clinical-pathways"
  "appointment-system|$WS/appointment-system"
  "signalbox-mcp|$WS/signalbox-mcp"
  "symphonix-health|$HOME/symphonix-health"
  "bullettrain-assistant-voice|$BT/bullettrain/assistant"
  "bullettrain-assistant-voice|$BT/bullettrain/voice"
  "mcp_care|$BT/mcp_care"
)

next_version_dir() {
  local repo="$1"
  local n=1
  while [[ -d "$repo/versions/v$n" ]]; do n=$((n+1)); done
  echo "$repo/versions/v$n"
}

run() {
  if [[ $DRY -eq 1 ]]; then echo "DRY: $*"; else eval "$@"; fi
}

ok=0; skip=0; fail=0
for entry in "${MAP[@]}"; do
  src_dir="${entry%%|*}"
  dst_repo="${entry##*|}"
  src_file="$PLANS_DIR/$src_dir/healthcare-pain-points.md"
  dst_dir="$dst_repo/plans/healthcare-pain-points"
  dst_file="$dst_dir/BUNDLE.md"

  if [[ ! -f "$src_file" ]]; then
    echo "MISSING SRC: $src_file"; fail=$((fail+1)); continue
  fi
  if [[ ! -d "$dst_repo" ]]; then
    echo "SKIP (no repo): $dst_repo"; skip=$((skip+1)); continue
  fi

  echo "→ $src_dir  =>  $dst_repo"
  run "mkdir -p '$dst_dir'"

  if [[ -f "$dst_file" ]]; then
    vdir="$(next_version_dir "$dst_repo")/plans/healthcare-pain-points"
    echo "  backup existing → $vdir/BUNDLE.md"
    run "mkdir -p '$vdir'"
    run "cp '$dst_file' '$vdir/BUNDLE.md'"
  fi

  run "cp '$src_file' '$dst_file'"

  # also drop a stub README pointing at the canonical source
  cat_msg="# Healthcare Pain-Points Bundle

Source of truth: https://github.com/GmailTedam/healthcare-pain-points-plan
Bundle: \`$src_dir/healthcare-pain-points.md\`

To start Phase B in a fresh Claude Code session, paste the **SESSION PROMPT**
section (§5) of \`BUNDLE.md\` and follow it.
"
  if [[ $DRY -eq 1 ]]; then
    echo "DRY: write README.md to $dst_dir"
  else
    printf "%s" "$cat_msg" > "$dst_dir/README.md"
  fi

  ok=$((ok+1))
done

echo
echo "Done. ok=$ok skip=$skip fail=$fail (dry-run=$DRY)"
