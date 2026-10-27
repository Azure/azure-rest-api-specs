import { describe, expect, it } from "vitest";
import { processArmReviewLabels } from "../../src/summarize-checks/labelling.ts";
import type { ImpactAssessment, ServiceImpact } from "../../../shared/src/impact.ts";
import type { ReviewContext } from "../../src/summarize-checks/review-requirements.ts";
import { updateLabels } from "../../src/summarize-checks/summarize-checks.ts";

const managementService: ServiceImpact = {
  path: "specification/example",
  plane: "resource-manager",
  changes: ["api"],
  typeSpec: true,
  newApiVersions: [],
  suppressionsChanged: false,
  resourceProvider: {
    newNamespaces: [],
    usesRpaas: false,
    hasAddedDefinitions: false,
    registered: false,
  },
};

function impact(service: Partial<ServiceImpact> = {}): ImpactAssessment {
  return { schemaVersion: 2, services: [{ ...managementService, ...service }] };
}

describe("update labels", () => {
  const newProvider = {
    ...managementService.resourceProvider,
    newNamespaces: ["specification/example/resource-manager/Microsoft.Example"],
    hasAddedDefinitions: true,
  };
  const testCases: {
    description: string;
    existingLabels: string[];
    expectedLabelsToAdd: string[];
    expectedLabelsToRemove: string[];
    impactAssessment: ImpactAssessment;
    context?: ReviewContext;
  }[] = [
    {
      description: "Add ARMReview and resource-manager labels when existing labels are empty",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["ARMReview", "resource-manager", "TypeSpec", "WaitForARMFeedback"],
      expectedLabelsToRemove: [],
      impactAssessment: impact(),
    },
    {
      description: "Shouldn't add ARM review if no management service changed",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec"],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ plane: "unknown" }),
    },
    {
      description: "Shouldn't add ARM review if not targeting a release branch",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec", "resource-manager"],
      expectedLabelsToRemove: [],
      impactAssessment: impact(),
      context: { isDraft: false, targetBranch: "a-test-branch" },
    },
    {
      description: "Shouldn't add add new-api-version if not targeting a release branch",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec", "resource-manager"],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ newApiVersions: ["2026-01-01"] }),
      context: { isDraft: false, targetBranch: "a-test-branch" },
    },
    {
      description: "Should add new-api-version correctly",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: [
        "TypeSpec",
        "resource-manager",
        "new-api-version",
        "ARMReview",
        "WaitForARMFeedback",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ newApiVersions: ["2026-01-01"] }),
    },
    {
      description: "Should add CI-NewRPNamespaceWithoutRPaaS for a new non-RPaaS namespace",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: [
        "TypeSpec",
        "resource-manager",
        "new-rp-namespace",
        "CI-NewRPNamespaceWithoutRPaaS",
        "ARMReview",
        "NotReadyForARMReview",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ resourceProvider: newProvider }),
    },
    {
      description: "Shouldn't remove RPaaSException when a new namespace needs it",
      existingLabels: ["other-label", "CI-NewRPNamespaceWithoutRPaaS", "RPaaSException"],
      expectedLabelsToAdd: [
        "TypeSpec",
        "resource-manager",
        "new-rp-namespace",
        "ARMReview",
        "WaitForARMFeedback",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ resourceProvider: newProvider }),
    },
    {
      description: "Shouldn't add any ARM process updates when not ready for ARM review",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: [
        "TypeSpec",
        "resource-manager",
        "CI-NewRPNamespaceWithoutRPaaS",
        "NotReadyForARMReview",
        "ARMReview",
        "new-api-version",
        "new-rp-namespace",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({
        resourceProvider: newProvider,
        newApiVersions: ["2026-01-01"],
      }),
    },
    {
      description:
        "Shouldn't remove NotReadyForARMReview label when not ready for ARM review due to being blocked on versioning or breaking change review.",
      existingLabels: [
        "ARMReview",
        "NotReadyForARMReview",
        "PipelineBotTrigger",
        "PublishToCustomers",
        "resource-manager",
        "RPaaS",
        "TypeSpec",
        "VersioningReviewRequired",
      ],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
      impactAssessment: impact({
        resourceProvider: { ...managementService.resourceProvider, usesRpaas: true },
      }),
      context: { isDraft: false, targetBranch: "RPSaaSMaster" },
    },
    {
      description:
        "Should remove NotReadyForARMReview and add WaitForARMFeedback when VersioningReviewRequired is approved.",
      existingLabels: [
        "ARMReview",
        "NotReadyForARMReview",
        "PipelineBotTrigger",
        "PublishToCustomers",
        "resource-manager",
        "RPaaS",
        "TypeSpec",
        "VersioningReviewRequired",
        "Versioning-Approved-Benign",
      ],
      expectedLabelsToAdd: ["WaitForARMFeedback"],
      expectedLabelsToRemove: ["NotReadyForARMReview"],
      impactAssessment: impact({
        resourceProvider: { ...managementService.resourceProvider, usesRpaas: true },
      }),
      context: { isDraft: false, targetBranch: "RPSaaSMaster" },
    },
    {
      description:
        "Should remove NotReadyForArmReview and add WaitForARMFeedback when CI-NewRPNamespaceWithoutRPaaS and RPaaSException",
      existingLabels: [
        "ARMReview",
        "CI-NewRPNamespaceWithoutRPaaS",
        "new-api-version",
        "new-rp-namespace",
        "NotReadyForARMReview",
        "resource-manager",
        "RPaaSException",
        "TypeSpec",
      ],
      expectedLabelsToAdd: ["WaitForARMFeedback"],
      expectedLabelsToRemove: ["NotReadyForARMReview"],
      impactAssessment: impact({
        resourceProvider: newProvider,
        newApiVersions: ["2026-01-01"],
      }),
    },
    {
      description:
        "Should remove WaitForARMFeedback when ARMSignedOff, CI-NewRPNamespaceWithoutRPaaS, and RPaaSException",
      existingLabels: [
        "ARMReview",
        "ARMSignedOff",
        "CI-NewRPNamespaceWithoutRPaaS",
        "new-api-version",
        "new-rp-namespace",
        "resource-manager",
        "RPaaSException",
        "TypeSpec",
        "WaitForARMFeedback",
      ],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["WaitForARMFeedback"],
      impactAssessment: impact({
        resourceProvider: newProvider,
        newApiVersions: ["2026-01-01"],
      }),
    },
    {
      description:
        "Should NOT remove ARMSignedOff when CI-RpaaSRPNotInPrivateRepo is set and RPaaSException is present",
      existingLabels: [
        "ARMReview",
        "ARMSignedOff",
        "CI-RpaaSRPNotInPrivateRepo",
        "new-api-version",
        "new-rp-namespace",
        "PublishToCustomers",
        "resource-manager",
        "RPaaS",
        "RPaaSException",
        "TypeSpec",
      ],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
      impactAssessment: impact({
        resourceProvider: { ...newProvider, usesRpaas: true },
        newApiVersions: ["2026-01-01"],
      }),
    },
    {
      description:
        "Should remove ARMSignedOff when CI-RpaaSRPNotInPrivateRepo is set and RPaaSException is NOT present",
      existingLabels: [
        "ARMReview",
        "ARMSignedOff",
        "CI-RpaaSRPNotInPrivateRepo",
        "new-api-version",
        "new-rp-namespace",
        "PublishToCustomers",
        "resource-manager",
        "RPaaS",
        "TypeSpec",
      ],
      expectedLabelsToAdd: ["NotReadyForARMReview"],
      expectedLabelsToRemove: ["ARMSignedOff"],
      impactAssessment: impact({
        resourceProvider: { ...newProvider, usesRpaas: true },
        newApiVersions: ["2026-01-01"],
      }),
    },
    {
      description:
        "Should add data-plane-review-requested for a data-plane PR with a new API version",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: [
        "TypeSpec",
        "data-plane",
        "new-api-version",
        "data-plane-review-requested",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ plane: "data-plane", newApiVersions: ["2026-01-01"] }),
    },
    {
      description: "Shouldn't add SuppressionReviewRequired for a data-plane PR",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec", "data-plane"],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ plane: "data-plane", suppressionsChanged: true }),
    },
    {
      description: "Should add SuppressionReviewRequired for a resource-manager PR",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: [
        "ARMReview",
        "resource-manager",
        "TypeSpec",
        "SuppressionReviewRequired",
        "WaitForARMFeedback",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ suppressionsChanged: true }),
    },
    {
      description:
        "Should add data-plane-review-requested even when an (unverified) sign-off label is already present",
      existingLabels: ["other-label", "data-plane-review-signoff"],
      expectedLabelsToAdd: [
        "TypeSpec",
        "data-plane",
        "new-api-version",
        "data-plane-review-requested",
      ],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ plane: "data-plane", newApiVersions: ["2026-01-01"] }),
    },
    {
      description:
        "Shouldn't remove data-plane-review-requested when a sign-off label is present (presence is not proof of sign-off)",
      existingLabels: [
        "other-label",
        "data-plane",
        "new-api-version",
        "data-plane-review-requested",
        "data-plane-review-signoff",
        "TypeSpec",
      ],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
      impactAssessment: impact({ plane: "data-plane", newApiVersions: ["2026-01-01"] }),
    },
    {
      description:
        "Add-only: keeps an existing data-plane-review-requested when the PR no longer qualifies (e.g. a manual request)",
      existingLabels: ["data-plane-review-requested", "other-label"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
      impactAssessment: { schemaVersion: 2, services: [] },
    },
  ];
  it.each(testCases)(
    "$description",
    ({
      existingLabels,
      expectedLabelsToAdd,
      expectedLabelsToRemove,
      impactAssessment,
      context = { isDraft: false, targetBranch: "main" },
    }) => {
      const labelContext = updateLabels(existingLabels, impactAssessment, context);

      expect([...labelContext.toAdd].sort()).toEqual(expectedLabelsToAdd.sort());
      expect([...labelContext.toRemove].sort()).toEqual(expectedLabelsToRemove.sort());
    },
  );

  it.each([
    { targetBranch: "release-network-2025-03-01", requiresReview: true },
    { targetBranch: "ARMCoreRPDev", requiresReview: true },
    { targetBranch: "feature/release-network-2025-03-01", requiresReview: false },
    { targetBranch: "feature/main", requiresReview: false },
    { targetBranch: "RPSaaSMaster-feature", requiresReview: false },
    { targetBranch: "ARMCoreRPDev-feature", requiresReview: false },
    // cspell:ignore releas
    { targetBranch: "releas", requiresReview: false },
  ])(
    "only adds review labels for release branches: $targetBranch",
    ({ targetBranch, requiresReview }) => {
      const labelContext = updateLabels([], impact({ newApiVersions: ["2026-01-01"] }), {
        isDraft: false,
        targetBranch,
      });

      expect([...labelContext.toAdd].sort()).toEqual(
        (requiresReview
          ? ["ARMReview", "TypeSpec", "WaitForARMFeedback", "new-api-version", "resource-manager"]
          : ["TypeSpec", "resource-manager"]
        ).sort(),
      );
      expect([...labelContext.toRemove]).toEqual([]);
    },
  );

  it("does not request data-plane review for a feature branch containing a release name", () => {
    const labelContext = updateLabels(
      [],
      impact({ plane: "data-plane", newApiVersions: ["2026-01-01"] }),
      { isDraft: false, targetBranch: "feature/release-network-2025-03-01" },
    );

    expect([...labelContext.toAdd].sort()).toEqual(["TypeSpec", "data-plane"]);
    expect([...labelContext.toRemove]).toEqual([]);
  });
});

describe("service-scoped impact labels", () => {
  const service = managementService;
  const context = { isDraft: false, targetBranch: "main" };

  it("keeps the resource-manager label but removes ARMReview for a configuration-only change", () => {
    const labels = updateLabels(
      ["ARMReview"],
      { schemaVersion: 2, services: [{ ...service, changes: ["sdk-configuration"] }] },
      context,
    );
    expect([...labels.toAdd].sort()).toEqual(["TypeSpec", "resource-manager"]);
    expect([...labels.toRemove]).toEqual(["ARMReview"]);
  });

  it("does not combine an ARM version addition with data-plane suppression changes", () => {
    const labels = updateLabels(
      [],
      {
        schemaVersion: 2,
        services: [
          { ...service, newApiVersions: ["2026-01-01"] },
          {
            ...service,
            plane: "data-plane",
            suppressionsChanged: true,
          },
        ],
      },
      context,
    );
    expect([...labels.toAdd].sort()).toEqual(
      [
        "ARMReview",
        "TypeSpec",
        "WaitForARMFeedback",
        "resource-manager",
        "data-plane",
        "new-api-version",
      ].sort(),
    );
  });

  it("evaluates the same artifact against current draft and branch state", () => {
    const impact = { schemaVersion: 2 as const, services: [service] };
    for (const current of [
      { isDraft: true, targetBranch: "main" },
      { isDraft: false, targetBranch: "feature/example" },
    ]) {
      const labels = updateLabels([], impact, current);
      expect([...labels.toAdd].sort()).toEqual(["TypeSpec", "resource-manager"]);
    }
    expect(updateLabels([], impact, context).toAdd.has("ARMReview")).toBe(true);
  });
});

describe("ARM review process labelling", () => {
  const testCases = [
    {
      existingLabels: ["WaitForARMFeedback", "ARMChangesRequested", "other-label", "ARMReview"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["WaitForARMFeedback"],
    },
    {
      existingLabels: ["other-label", "ARMChangesRequested"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
    },
    {
      existingLabels: [
        "WaitForARMFeedback",
        "ARMSignedOff",
        "ARMChangesRequested",
        "other-label",
        "ARMReview",
      ],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["WaitForARMFeedback", "ARMChangesRequested"],
    },
    {
      existingLabels: ["WaitForARMFeedback", "ARMSignedOff", "other-label", "ARMReview"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["WaitForARMFeedback"],
    },
    {
      existingLabels: ["ARMChangesRequested", "ARMSignedOff", "other-label", "ARMReview"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["ARMChangesRequested"],
    },
    {
      existingLabels: ["other-label", "ARMSignedOff"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
    },
    {
      existingLabels: ["WaitForARMFeedback", "other-label", "ARMReview"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: [],
    },
    {
      existingLabels: ["other-label", "ARMReview"],
      expectedLabelsToAdd: ["WaitForARMFeedback"],
      expectedLabelsToRemove: [],
    },
    {
      existingLabels: ["WaitForARMFeedback", "ARMChangesRequested", "ARMReview"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["WaitForARMFeedback"],
    },
    {
      existingLabels: ["WaitForARMFeedback", "ARMChangesRequested", "ARMReview"],
      expectedLabelsToAdd: [],
      expectedLabelsToRemove: ["WaitForARMFeedback"],
    },
  ];

  it.each(testCases)(
    "$description",
    ({ existingLabels, expectedLabelsToAdd, expectedLabelsToRemove }) => {
      const labelContext: import("../../src/summarize-checks/labelling.ts").LabelContext = {
        present: new Set(),
        toAdd: new Set(),
        toRemove: new Set(),
      };
      processArmReviewLabels(labelContext, existingLabels);

      expect([...labelContext.toAdd].sort()).toEqual(expectedLabelsToAdd.sort());
      expect([...labelContext.toRemove].sort()).toEqual(expectedLabelsToRemove.sort());
    },
  );
});
