import assert from "node:assert/strict";
import test from "node:test";
import { extractApiVersions, selectApiVersionPair } from "./api-version-selection.mjs";

const source = (members) => `
@versioned(Versions)
namespace Contoso;
enum Versions {
${members}
}`;

test("selects a newly added head version and the latest stable base version", () => {
  const base = extractApiVersions([source(`
  v2025_01_01: "2025-01-01",
  @Azure.Core.previewVersion
  v2025_06_01_preview: "2025-06-01-preview",
  `)]);
  const current = extractApiVersions([source(`
  v2025_01_01: "2025-01-01",
  @Azure.Core.previewVersion
  v2025_06_01_preview: "2025-06-01-preview",
  @Azure.Core.previewVersion
  v2026_01_01_preview: "2026-01-01-preview",
  `)]);

  assert.deepEqual(selectApiVersionPair({
    base,
    current,
    baseCommit: "base-sha",
    headCommit: "head-sha",
  }), {
    mode: "new-api-version",
    baseline: {
      sourceRevision: "current",
      commit: "head-sha",
      apiVersion: "2025-01-01",
      reason: "previous-latest-stable",
    },
    target: {
      sourceRevision: "current",
      commit: "head-sha",
      apiVersion: "2026-01-01-preview",
      reason: "newest-added-version",
    },
    base: "2025-01-01",
    current: "2026-01-01-preview",
    baseReason: "previous-latest-stable",
    currentReason: "new-version-added",
    addedCurrentVersions: ["2026-01-01-preview"],
    available: {
      base: ["2025-01-01", "2025-06-01-preview"],
      current: ["2025-01-01", "2025-06-01-preview", "2026-01-01-preview"],
    },
  });
});

test("uses the latest head version and latest preview base when no stable exists", () => {
  const base = extractApiVersions([source(`
  v2024_01_01_preview: "2024-01-01-preview",
  v2025_01_01_preview: "2025-01-01-preview",
  `)]);
  const current = extractApiVersions([source(`
  v2024_01_01_preview: "2024-01-01-preview",
  v2025_01_01_preview: "2025-01-01-preview",
  `)]);
  const pair = selectApiVersionPair({ base, current });

  assert.equal(pair.base, "2025-01-01-preview");
  assert.equal(pair.current, "2025-01-01-preview");
  assert.equal(pair.mode, "existing-api-version");
  assert.equal(pair.baseline.sourceRevision, "base");
  assert.equal(pair.baseReason, "affected-existing-version");
  assert.equal(pair.currentReason, "latest-version");
});

test("uses the same latest preview on both sides when the PR adds no version", () => {
  const versions = extractApiVersions([source(`
  v2025_01_01: "2025-01-01",
  v2026_05_01_preview: "2026-05-01-preview",
  `)]);
  const pair = selectApiVersionPair({ base: versions, current: versions });

  assert.equal(pair.base, "2026-05-01-preview");
  assert.equal(pair.current, "2026-05-01-preview");
  assert.equal(pair.mode, "existing-api-version");
  assert.equal(pair.baseReason, "affected-existing-version");
  assert.equal(pair.currentReason, "latest-version");
});

test("does not select a version for an unversioned project", () => {
  const unversioned = extractApiVersions(["namespace Contoso;"]);
  const pair = selectApiVersionPair({ base: unversioned, current: unversioned });

  assert.equal(pair.base, undefined);
  assert.equal(pair.current, undefined);
  assert.equal(pair.mode, "unversioned");
  assert.equal(pair.baseline.sourceRevision, "base");
  assert.equal(pair.currentReason, "unversioned");
});

test("compares an unversioned base with a versioned target", () => {
  const pair = selectApiVersionPair({
    base: extractApiVersions(["namespace Contoso;"]),
    current: extractApiVersions([source(`
  v2025_01_01: "2025-01-01",
  v2026_01_01_preview: "2026-01-01-preview",
  `)]),
    baseCommit: "base-sha",
    headCommit: "head-sha",
  });

  assert.equal(pair.mode, "existing-api-version");
  assert.equal(pair.versioningChange, "unversioned-to-versioned");
  assert.equal(pair.baseline.sourceRevision, "base");
  assert.equal(pair.baseline.apiVersion, undefined);
  assert.equal(pair.target.sourceRevision, "current");
  assert.equal(pair.target.apiVersion, "2026-01-01-preview");
  assert.deepEqual(pair.addedCurrentVersions, [
    "2025-01-01",
    "2026-01-01-preview",
  ]);
});

test("compares a versioned base with an unversioned target", () => {
  const pair = selectApiVersionPair({
    base: extractApiVersions([source(`
  v2025_01_01: "2025-01-01",
  v2026_01_01_preview: "2026-01-01-preview",
  `)]),
    current: extractApiVersions(["namespace Contoso;"]),
    baseCommit: "base-sha",
    headCommit: "head-sha",
  });

  assert.equal(pair.mode, "existing-api-version");
  assert.equal(pair.versioningChange, "versioned-to-unversioned");
  assert.equal(pair.baseline.sourceRevision, "base");
  assert.equal(pair.baseline.apiVersion, "2026-01-01-preview");
  assert.equal(pair.target.sourceRevision, "current");
  assert.equal(pair.target.apiVersion, undefined);
  assert.equal(pair.currentReason, "unversioned");
});
