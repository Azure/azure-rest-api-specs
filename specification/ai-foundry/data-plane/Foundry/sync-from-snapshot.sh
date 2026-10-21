#!/usr/bin/env bash
#
# sync-from-snapshot.sh
# -----------------------------------------------------------------------------
# Updates the `feature/foundry-release` branch of Azure/azure-rest-api-specs with
# the merged Foundry spec produced by the create-snapshot.lock.yml workflow in
# https://github.com/coreai-microsoft/foundry-spec-snapshot
#
# The snapshot workflow merges every open PR targeting feature/foundry-release
# into a single validated tree. The files it (re)produces are:
#   - package.json                                    (repo root)
#   - package-lock.json                               (repo root)
#   - specification/ai-foundry/**  (TypeSpec sources)
#
# This script copies those into your local azure-rest-api-specs checkout,
# regenerates the OpenAPI3 swagger, then validates the result via `npx tsv .`
# (per the Foundry README). An isolated Git baseline lets `tsv` verify that
# compilation is deterministic without mistaking the synchronized files for
# compiler output that was not checked in.
#
# WHERE THIS LIVES / HOW TO RUN:
#   This script is meant to live in and be run from:
#     azure-rest-api-specs/specification/ai-foundry/data-plane/Foundry
#
#   Usage:
#     ./sync-from-snapshot.sh [snapshot-ref]
#
#   Examples:
#     ./sync-from-snapshot.sh                      # latest snapshot (main)
#     ./sync-from-snapshot.sh snapshot-1730000000  # a specific tagged snapshot
#     ./sync-from-snapshot.sh <commit-sha>         # a specific snapshot commit
# -----------------------------------------------------------------------------

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
SNAPSHOT_REF="${1:-main}"
SNAPSHOT_REPO="${SNAPSHOT_REPO:-https://github.com/coreai-microsoft/foundry-spec-snapshot.git}"

# Basename of this script. It lives inside the tree being synchronized, so it
# must be preserved while the rest of that tree is replaced.
SELF_NAME="$(basename "${BASH_SOURCE[0]}")"

# Path (relative to the azure-rest-api-specs repo root) where the Foundry
# TypeSpec sources live in BOTH repos.
AI_FOUNDRY_REL="specification/ai-foundry"

# Path (relative to the azure-rest-api-specs repo root) where the Foundry
# Script lives and npx tsv . is run. This is also where the OpenAPI3 output is generated.
FOUNDRY_REL="specification/ai-foundry/data-plane/Foundry"

# Branch we expect to be updating in azure-rest-api-specs.
EXPECTED_BRANCH="feature/foundry-release"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
info()  { printf '\033[0;36m%s\033[0m\n' "$*"; }
ok()    { printf '\033[0;32m%s\033[0m\n' "$*"; }
warn()  { printf '\033[0;33m%s\033[0m\n' "$*" >&2; }
die()   { printf '\033[0;31m❌ %s\033[0m\n' "$*" >&2; exit 1; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

# -----------------------------------------------------------------------------
# Preflight
# -----------------------------------------------------------------------------
require_cmd git
require_cmd node
require_cmd npm
require_cmd npx
require_cmd find
require_cmd mktemp

[ "$#" -le 1 ] || die "Usage: $SELF_NAME [snapshot-ref]"
case "$SNAPSHOT_REF" in
  -*) die "Snapshot ref must not begin with '-'." ;;
esac

# Resolve the azure-rest-api-specs repo root from wherever we were invoked.
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" \
  || die "Not inside a git repository. Run this from azure-rest-api-specs/${FOUNDRY_REL}."

AI_FOUNDRY_DIR="${REPO_ROOT}/${AI_FOUNDRY_REL}"
[ -d "$AI_FOUNDRY_DIR" ] \
  || die "Expected '${AI_FOUNDRY_REL}' under repo root '${REPO_ROOT}'. Are you in the azure-rest-api-specs repo?"

FOUNDRY_DIR="${REPO_ROOT}/${FOUNDRY_REL}"
[ -d "$FOUNDRY_DIR" ] \
  || die "Expected '${FOUNDRY_REL}' under repo root '${REPO_ROOT}'. Are you in the azure-rest-api-specs repo?"

DATA_PLANE_DIR="$(dirname "$FOUNDRY_DIR")"
DATA_PLANE_NAME="$(basename "$DATA_PLANE_DIR")"
FOUNDRY_NAME="$(basename "$FOUNDRY_DIR")"
SELF_PATH="${FOUNDRY_DIR}/${SELF_NAME}"
[ -f "$SELF_PATH" ] \
  || die "Expected this script at '${SELF_PATH}'."

# Warn (don't block) if we're not on the expected branch.
CURRENT_BRANCH="$(git -C "$REPO_ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'UNKNOWN')"
if [ "$CURRENT_BRANCH" != "$EXPECTED_BRANCH" ]; then
  warn "⚠️  Current branch is '${CURRENT_BRANCH}', expected '${EXPECTED_BRANCH}'."
  warn "    The script will still apply changes to the working tree. Switch branches first if this is not intended."
fi

# Warn if the working tree already has staged, unstaged, or untracked changes
# to the synced paths.
if [ -n "$(git -C "$REPO_ROOT" status --porcelain --untracked-files=all -- \
  "$AI_FOUNDRY_REL" package.json package-lock.json 2>/dev/null)" ]; then
  warn "⚠️  You have uncommitted changes in package.json, package-lock.json, or ${AI_FOUNDRY_REL}."
  warn "    These will be overwritten by the snapshot contents. Stash or commit first if you want to keep them."
fi

# -----------------------------------------------------------------------------
# Fetch the snapshot into a temp dir
# -----------------------------------------------------------------------------
TEMP_DIR="$(mktemp -d)"
SELF_BACKUP="$(mktemp)"
VALIDATION_GIT_DIR=""
cleanup() {
  rm -rf "$TEMP_DIR"
  rm -f "$SELF_BACKUP"
  if [ -n "$VALIDATION_GIT_DIR" ]; then
    rm -rf "$VALIDATION_GIT_DIR"
  fi
}
trap cleanup EXIT

info "📦 Fetching snapshot ref '${SNAPSHOT_REF}' from ${SNAPSHOT_REPO}"
git -C "$TEMP_DIR" init -q
git -C "$TEMP_DIR" remote add origin "$SNAPSHOT_REPO"
git -C "$TEMP_DIR" fetch -q --depth 1 origin "$SNAPSHOT_REF" \
  || die "Could not fetch ref '${SNAPSHOT_REF}' from ${SNAPSHOT_REPO} (check the ref and repository access)."
git -C "$TEMP_DIR" checkout -q --detach FETCH_HEAD \
  || die "Could not checkout ref '${SNAPSHOT_REF}'."

SNAP_FOUNDRY="${TEMP_DIR}/${AI_FOUNDRY_REL}"
[ -d "$SNAP_FOUNDRY" ] \
  || die "Snapshot does not contain '${AI_FOUNDRY_REL}'. Is '${SNAPSHOT_REF}' a valid snapshot ref?"
[ -f "${TEMP_DIR}/package.json" ] \
  || die "Snapshot does not contain package.json."
[ -f "${TEMP_DIR}/package-lock.json" ] \
  || die "Snapshot does not contain package-lock.json."

# -----------------------------------------------------------------------------
# Report which PRs are in this snapshot (audit trail)
# -----------------------------------------------------------------------------
SNAP_MANIFEST="${TEMP_DIR}/merge-manifest.json"
if [ -f "$SNAP_MANIFEST" ]; then
  SNAP_SHA="$(git -C "$TEMP_DIR" rev-parse --short HEAD 2>/dev/null || echo 'unknown')"
  info "📋 Snapshot ${SNAP_SHA} includes these PRs:"
  node -e '
    const prs = require(process.argv[1]);
    for (const pr of prs) console.log(`   #${pr.number} — ${pr.title}`);
  ' "$SNAP_MANIFEST" || true
else
  warn "merge-manifest.json not found in snapshot (continuing without audit list)."
fi

# -----------------------------------------------------------------------------
# Copy snapshot files into the azure-rest-api-specs working tree
# -----------------------------------------------------------------------------
info "📦 Syncing files from snapshot into ${REPO_ROOT}"

# package.json / package-lock.json live at the azure-rest-api-specs repo ROOT.
cp "${TEMP_DIR}/package.json" "${REPO_ROOT}/package.json"
ok "  ✓ package.json"
cp "${TEMP_DIR}/package-lock.json" "${REPO_ROOT}/package-lock.json"
ok "  ✓ package-lock.json"

# TypeSpec sources: clear the ai-foundry tree in place so deletions propagate.
# Preserve the directory chain containing this script because the parent shell
# may be running from Foundry, which prevents removing that directory on Windows.
cp "$SELF_PATH" "$SELF_BACKUP"
find "$AI_FOUNDRY_DIR" -mindepth 1 -maxdepth 1 ! -name "$DATA_PLANE_NAME" -exec rm -rf -- {} +
find "$DATA_PLANE_DIR" -mindepth 1 -maxdepth 1 ! -name "$FOUNDRY_NAME" -exec rm -rf -- {} +
find "$FOUNDRY_DIR" -mindepth 1 -maxdepth 1 ! -name "$SELF_NAME" -exec rm -rf -- {} +
cp -r "$SNAP_FOUNDRY"/. "$AI_FOUNDRY_DIR"/
# Restore the local script in case the snapshot contained a file with this name.
cp "$SELF_BACKUP" "$SELF_PATH"
ok "  ✓ ${AI_FOUNDRY_REL}/"

# Keep the manifest locally (untracked) as an audit reference.
if [ -f "$SNAP_MANIFEST" ]; then
  cp "$SNAP_MANIFEST" "${REPO_ROOT}/${FOUNDRY_REL}/.sync-manifest.json"
  ok "  ✓ .sync-manifest.json (audit reference — not part of the spec)"
fi

# -----------------------------------------------------------------------------
# Install tools, regenerate OpenAPI3, and validate
# -----------------------------------------------------------------------------
info "🔧 Installing dependencies (npm ci) at repo root..."
( cd "$REPO_ROOT" && npm ci --ignore-scripts ) || die "npm ci failed."
ok "  ✓ dependencies installed"

mkdir -p "${FOUNDRY_DIR}/examples"   # TypeSpec validation expects this folder.
info "🎨 Formatting TypeSpec sources..."
( cd "$FOUNDRY_DIR" && \
  npx tsp format "../**/*.tsp" && \
  npx prettier --write tspconfig.yaml ) \
  || die "TypeSpec formatting failed — see output above."
ok "  ✓ TypeSpec sources formatted"

info "🛠  Regenerating OpenAPI3 via 'npx tsp compile .'..."
( cd "$FOUNDRY_DIR" && npx tsp compile --warn-as-error . ) \
  || die "TypeSpec compilation failed — see output above."
ok "  ✓ OpenAPI3 generated"

# `tsv` requires the specification tree to be Git-clean after it compiles. The
# real working tree intentionally contains the sync diff, so give validation a
# temporary Git repository whose baseline is the newly synchronized, generated
# state. This does not modify the real branch, index, or staging area.
VALIDATION_GIT_DIR="$(mktemp -d)"
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    VALIDATION_GIT_DIR_NATIVE="$(cd "$VALIDATION_GIT_DIR" && pwd -W)"
    ;;
  *)
    VALIDATION_GIT_DIR_NATIVE="$VALIDATION_GIT_DIR"
    ;;
esac
git -C "$REPO_ROOT" --git-dir="$VALIDATION_GIT_DIR_NATIVE" --work-tree="$REPO_ROOT" init -q
git -C "$REPO_ROOT" --git-dir="$VALIDATION_GIT_DIR_NATIVE" --work-tree="$REPO_ROOT" config user.name "Foundry snapshot sync"
git -C "$REPO_ROOT" --git-dir="$VALIDATION_GIT_DIR_NATIVE" --work-tree="$REPO_ROOT" config user.email "foundry-snapshot-sync@localhost"
printf '/*\n' > "${VALIDATION_GIT_DIR}/info/exclude"
git -C "$REPO_ROOT" --git-dir="$VALIDATION_GIT_DIR_NATIVE" --work-tree="$REPO_ROOT" add -f -- \
  package.json package-lock.json "$AI_FOUNDRY_REL"
git -C "$REPO_ROOT" --git-dir="$VALIDATION_GIT_DIR_NATIVE" --work-tree="$REPO_ROOT" commit -q -m "Validation baseline"

info "🔍 Validating generated files via 'npx tsv .'..."
( cd "$FOUNDRY_DIR" && \
  GIT_DIR="$VALIDATION_GIT_DIR_NATIVE" GIT_WORK_TREE="$REPO_ROOT" npx tsv . ) \
  || die "TypeSpec validation (npx tsv .) failed — see output above."
ok "  ✓ TypeSpec validation passed"

# -----------------------------------------------------------------------------
# Done — print review/commit/push guidance
# -----------------------------------------------------------------------------
ok ""
ok "✅ Sync complete."
cat <<EOF

📋 Next steps (review → commit → push to ${EXPECTED_BRANCH}):

  1. Review ALL changes (TypeSpec sources + generated OpenAPI3 + deps):
       git -C "${REPO_ROOT}" status
       git -C "${REPO_ROOT}" diff

  2. Make sure you are on the target branch:
       git -C "${REPO_ROOT}" checkout ${EXPECTED_BRANCH}

  3. Stage and commit (include BOTH sources and generated swagger):
       git -C "${REPO_ROOT}" add package.json package-lock.json ${AI_FOUNDRY_REL}
       git -C "${REPO_ROOT}" commit -m "Sync Foundry spec from snapshot (${SNAPSHOT_REF})"

  4. Push:
       git -C "${REPO_ROOT}" push origin ${EXPECTED_BRANCH}

  (.sync-manifest.json lists the PRs included in this snapshot — for reference only; do not commit it.)
EOF
