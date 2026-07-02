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
#   - specification/ai-foundry/data-plane/Foundry/**  (TypeSpec sources)
#
# This script copies those into your local azure-rest-api-specs checkout, then
# regenerates the OpenAPI3 spec via `npx tsp compile .` (running the
# `@typespec/openapi3` emitter configured in tspconfig.yaml), so your `git diff`
# contains both the TypeSpec sources AND the generated OpenAPI.
#
# WHERE THIS LIVES / HOW TO RUN:
#   This script is meant to live in and be run from:
#     azure-rest-api-specs/specification/ai-foundry
#
#   It lives OUTSIDE the Foundry tree it replaces, so it can safely wipe and
#   recreate that tree without deleting itself or hitting a "directory busy"
#   error on Windows.
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

# Path (relative to the azure-rest-api-specs repo root) where the Foundry
# TypeSpec sources live in BOTH repos.
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

# Resolve the azure-rest-api-specs repo root from wherever we were invoked.
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" \
  || die "Not inside a git repository. Run this from azure-rest-api-specs/specification/ai-foundry."

FOUNDRY_DIR="${REPO_ROOT}/${FOUNDRY_REL}"
[ -d "$FOUNDRY_DIR" ] \
  || die "Expected '${FOUNDRY_REL}' under repo root '${REPO_ROOT}'. Are you in the azure-rest-api-specs repo?"

# Warn (don't block) if we're not on the expected branch.
CURRENT_BRANCH="$(git -C "$REPO_ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'UNKNOWN')"
if [ "$CURRENT_BRANCH" != "$EXPECTED_BRANCH" ]; then
  warn "⚠️  Current branch is '${CURRENT_BRANCH}', expected '${EXPECTED_BRANCH}'."
  warn "    The script will still apply changes to the working tree. Switch branches first if this is not intended."
fi

# Warn if the working tree already has uncommitted changes to the synced paths.
if ! git -C "$REPO_ROOT" diff --quiet -- "$FOUNDRY_REL" package.json package-lock.json 2>/dev/null; then
  warn "⚠️  You have uncommitted changes in package.json, package-lock.json, or ${FOUNDRY_REL}."
  warn "    These will be overwritten by the snapshot contents. Stash or commit first if you want to keep them."
fi

# -----------------------------------------------------------------------------
# Fetch the snapshot into a temp dir
# -----------------------------------------------------------------------------
TEMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TEMP_DIR"; }
trap cleanup EXIT

info "📦 Fetching snapshot ref '${SNAPSHOT_REF}' from ${SNAPSHOT_REPO}"

# A 40-hex commit SHA can't be used with `git clone --branch`, so go straight
# to the clone-default + fetch-SHA path for those. Branch/tag names use the
# fast shallow single-ref clone.
clone_by_fetch() {
  rm -rf "$TEMP_DIR" && mkdir -p "$TEMP_DIR"
  git clone --depth 1 "$SNAPSHOT_REPO" "$TEMP_DIR" >/dev/null 2>&1 \
    || die "Could not clone ${SNAPSHOT_REPO} (check access — the repo is private)."
  git -C "$TEMP_DIR" fetch --depth 1 origin "$SNAPSHOT_REF" >/dev/null 2>&1 \
    || die "Could not fetch ref '${SNAPSHOT_REF}' from the snapshot repo."
  git -C "$TEMP_DIR" checkout -q FETCH_HEAD \
    || die "Could not checkout ref '${SNAPSHOT_REF}'."
}

if [[ "$SNAPSHOT_REF" =~ ^[0-9a-fA-F]{40}$ ]]; then
  info "   (ref looks like a commit SHA — cloning default branch then fetching it)"
  clone_by_fetch
elif git clone --depth 1 --branch "$SNAPSHOT_REF" "$SNAPSHOT_REPO" "$TEMP_DIR" >/dev/null 2>&1; then
  : # Branch or tag clone succeeded.
else
  # Fall back: full-ish clone, then fetch the specific ref (commit SHA or ref).
  warn "Direct branch/tag clone failed; trying default clone + fetch of '${SNAPSHOT_REF}'..."
  clone_by_fetch
fi

SNAP_FOUNDRY="${TEMP_DIR}/${FOUNDRY_REL}"
[ -d "$SNAP_FOUNDRY" ] \
  || die "Snapshot does not contain '${FOUNDRY_REL}'. Is '${SNAPSHOT_REF}' a valid snapshot ref?"

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
if [ -f "${TEMP_DIR}/package.json" ]; then
  cp "${TEMP_DIR}/package.json" "${REPO_ROOT}/package.json"
  ok "  ✓ package.json"
else
  warn "  • package.json not in snapshot — skipping"
fi

if [ -f "${TEMP_DIR}/package-lock.json" ]; then
  cp "${TEMP_DIR}/package-lock.json" "${REPO_ROOT}/package-lock.json"
  ok "  ✓ package-lock.json"
else
  warn "  • package-lock.json not in snapshot — skipping"
fi

# TypeSpec sources: replace the Foundry tree so deletions propagate.
#
# This script lives OUTSIDE the Foundry tree (in specification/ai-foundry), and
# is NOT run with the Foundry directory as its current working directory, so we
# can safely remove and recreate the whole tree. This guarantees deletions in
# the snapshot propagate and avoids the Windows "directory busy" problem that
# occurred when the script previously ran from inside the Foundry folder.
rm -rf "$FOUNDRY_DIR"
mkdir -p "$FOUNDRY_DIR"
# Copy snapshot contents (including dotfiles) into the recreated directory.
cp -r "$SNAP_FOUNDRY"/. "$FOUNDRY_DIR"/
ok "  ✓ ${FOUNDRY_REL}/"

# Keep the manifest locally (untracked) as an audit reference.
if [ -f "$SNAP_MANIFEST" ]; then
  cp "$SNAP_MANIFEST" "${REPO_ROOT}/.sync-manifest.json"
  ok "  ✓ .sync-manifest.json (audit reference — not part of the spec)"
fi

# -----------------------------------------------------------------------------
# Install tools + regenerate OpenAPI3 (npx tsp compile .)
# -----------------------------------------------------------------------------
# package.json lives at the repo root, so install dependencies there.
info "🔧 Installing dependencies (npm ci) at repo root..."
( cd "$REPO_ROOT" && npm ci ) || die "npm ci failed."
ok "  ✓ dependencies installed"

# Emit the OpenAPI3 spec from the Foundry folder.
#
# This project intentionally uses the '@typespec/openapi3' emitter (configured
# in tspconfig.yaml) to produce OpenAPI 3.x under ${FOUNDRY_REL}/openapi3/. We
# therefore run 'npx tsp compile .', which invokes exactly the emitters listed
# in tspconfig.yaml. Do NOT use 'npx tsv .' here: the TypeSpecValidation tool's
# EmitAutorest rule requires the '@azure-tools/typespec-autorest' (swagger)
# emitter and fails on this openapi3-only project.
info "🛠  Generating OpenAPI3 via 'npx tsp compile .' (from ${FOUNDRY_REL})..."
( cd "$FOUNDRY_DIR" && npx tsp compile . ) || die "TypeSpec compilation (npx tsp compile .) failed — see output above."
ok "  ✓ OpenAPI3 generated"

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
       git -C "${REPO_ROOT}" add package.json package-lock.json ${FOUNDRY_REL} specification/ai-foundry/data-plane
       git -C "${REPO_ROOT}" commit -m "Sync Foundry spec from snapshot (${SNAPSHOT_REF})"

  4. Push:
       git -C "${REPO_ROOT}" push origin ${EXPECTED_BRANCH}

  (.sync-manifest.json lists the PRs included in this snapshot — for reference only; do not commit it.)
EOF
