import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { parse } from "yaml";
import {
  BREAKING_CHANGES_CHECK_TYPES,
  breakingChangesCheckType,
  isReviewRequiredLabel,
  isValidBreakingChangeApproval,
  isValidVersioningApproval,
} from "../src/breaking-change.ts";
import {
  APPROVAL_PREFIX_LABELS,
  ArmAutoSignoffLabel,
  ArmModelingLabel,
  ArmReviewLabel,
  autoSignoffMarkers,
  BREAKING_CHANGE_APPROVALS,
  DataPlaneReviewLabel,
  legacyAutoSignoffMarkers,
  PackageNameLabel,
  REVIEW_REQUIRED_LABELS,
  sdkLabels,
  SpecPlaneLabel,
  SpecPrLabel,
  SwaggerSuppressionLabel,
  TypeSpecSuppressionLabel,
  VERSIONING_APPROVALS,
} from "../src/labels.ts";

interface LabelCatalogFragment {
  extends?: string[];
  labels?: { name: string }[];
}

function loadConfiguredLabelNames(catalogPath: string, visited = new Set<string>()): Set<string> {
  const fullPath = resolve(catalogPath);
  if (visited.has(fullPath)) {
    return new Set();
  }
  visited.add(fullPath);

  const document = parse(readFileSync(fullPath, "utf8")) as LabelCatalogFragment;
  const names = new Set<string>();
  for (const parent of document.extends ?? []) {
    for (const name of loadConfiguredLabelNames(resolve(dirname(fullPath), parent), visited)) {
      names.add(name);
    }
  }
  for (const entry of document.labels ?? []) {
    names.add(entry.name);
  }
  return names;
}

describe("labels", () => {
  it("defines every spec-repo label constant in .github/labels.yaml", () => {
    const catalogPath = resolve(import.meta.dirname, "..", "..", "labels.yaml");
    const configuredLabels = loadConfiguredLabelNames(catalogPath);

    // Labels intentionally absent from this repo's .github/labels.yaml:
    // - `auto-sdk-build-fix` is applied to generated SDK PRs in `azure-sdk-for-net`.
    // - `skip-arm-review` is an opt-out label checked by ARM review dispatch.
    const nonCatalogLabels = new Set<string>([
      sdkLabels["azure-sdk-for-net"].buildFailed,
      ArmReviewLabel.SkipArmReview,
    ]);

    const allRepoLabels = [
      ...Object.values(VERSIONING_APPROVALS),
      ...Object.values(BREAKING_CHANGE_APPROVALS),
      ...Object.values(REVIEW_REQUIRED_LABELS),
      ...Object.values(sdkLabels).flatMap((entry) =>
        [
          entry.breakingChange,
          entry.breakingChangeApproved,
          entry.breakingChangeSuppression,
          entry.breakingChangeSuppressionApproved,
          entry.buildFailed,
        ].filter((label) => label !== undefined),
      ),
      ...Object.values(TypeSpecSuppressionLabel),
      ...Object.values(SwaggerSuppressionLabel),
      ...Object.values(ArmAutoSignoffLabel),
      ...Object.values(ArmReviewLabel),
      ...Object.values(ArmModelingLabel),
      ...Object.values(SpecPlaneLabel),
      ...Object.values(DataPlaneReviewLabel),
      ...Object.values(PackageNameLabel),
      ...Object.values(SpecPrLabel),
    ];

    const missing = [...new Set(allRepoLabels)].filter(
      (label) => !nonCatalogLabels.has(label) && !configuredLabels.has(label),
    );
    expect(missing).toEqual([]);
  });

  it("matches every breaking-change and versioning approval label to its prefix pattern", () => {
    const versioningPrefix = APPROVAL_PREFIX_LABELS.VERSIONING.slice(0, -1);
    const breakingChangePrefix = APPROVAL_PREFIX_LABELS.BREAKING_CHANGE.slice(0, -1);

    for (const label of Object.values(VERSIONING_APPROVALS)) {
      expect(label.startsWith(versioningPrefix)).toBe(true);
    }
    for (const label of Object.values(BREAKING_CHANGE_APPROVALS)) {
      expect(label.startsWith(breakingChangePrefix)).toBe(true);
    }
  });

  it("includes current and legacy auto-signoff markers", () => {
    expect(autoSignoffMarkers).toContain(ArmAutoSignoffLabel.ArmAutoSignedOff);
    for (const marker of legacyAutoSignoffMarkers) {
      expect(autoSignoffMarkers).toContain(marker);
    }
  });
});

describe("breaking-change helpers", () => {
  it("classifies versioning, breaking-change, and review-required labels", () => {
    expect(isValidVersioningApproval(VERSIONING_APPROVALS.BENIGN)).toBe(true);
    expect(isValidVersioningApproval(BREAKING_CHANGE_APPROVALS.BENIGN)).toBe(false);

    expect(isValidBreakingChangeApproval(BREAKING_CHANGE_APPROVALS.SECURITY)).toBe(true);
    expect(isValidBreakingChangeApproval(VERSIONING_APPROVALS.RETIRED)).toBe(false);

    expect(isReviewRequiredLabel(REVIEW_REQUIRED_LABELS.VERSIONING)).toBe(true);
    expect(isReviewRequiredLabel(REVIEW_REQUIRED_LABELS.BREAKING_CHANGE)).toBe(true);
    expect(isReviewRequiredLabel("unrelated-label")).toBe(false);
  });

  it("wires check-type configs to the consolidated label constants", () => {
    expect(breakingChangesCheckType[BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION]).toEqual({
      reviewRequiredLabel: REVIEW_REQUIRED_LABELS.VERSIONING,
      approvalPrefixLabel: APPROVAL_PREFIX_LABELS.VERSIONING,
      approvalLabels: Object.values(VERSIONING_APPROVALS),
    });
    expect(breakingChangesCheckType[BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION]).toEqual({
      reviewRequiredLabel: REVIEW_REQUIRED_LABELS.BREAKING_CHANGE,
      approvalPrefixLabel: APPROVAL_PREFIX_LABELS.BREAKING_CHANGE,
      approvalLabels: Object.values(BREAKING_CHANGE_APPROVALS),
    });
  });
});
