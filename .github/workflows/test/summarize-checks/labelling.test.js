import { describe, expect, it } from "vitest";
import { processArmReviewLabels } from "../../src/summarize-checks/labelling.js";
import { updateLabels } from "../../src/summarize-checks/summarize-checks.js";

describe("update labels", () => {
  const testCases = [
    {
      description: "Add ARMReview and resource-manager labels when existing labels are empty",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["ARMReview", "resource-manager", "TypeSpec", "WaitForARMFeedback"],
      expectedLabelsToRemove: [],
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Shouldn't add ARM review if resourceManagerRequired is false",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec"],
      expectedLabelsToRemove: [],
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: false,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Shouldn't add ARM review if not targeting a release branch",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec", "resource-manager"],
      expectedLabelsToRemove: [],
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "a-test-branch",
      },
    },
    {
      description: "Shouldn't add add new-api-version if not targeting a release branch",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec", "resource-manager"],
      expectedLabelsToRemove: [],
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "a-test-branch",
      },
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
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Should add CI-NewRPNamespaceWithoutRPaaS label properly",
      existingLabels: ["other-label"],
      expectedLabelsToAdd: ["TypeSpec", "resource-manager", "CI-NewRPNamespaceWithoutRPaaS"],
      expectedLabelsToRemove: [],
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: true,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "a-test-branch",
      },
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
      ],
      expectedLabelsToRemove: [],
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: true,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "main",
      },
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
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: true,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "RPSaaSMaster",
      },
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
      impactAssessment: {
        suppressionReviewRequired: false,
        rpaasChange: true,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        rpaasExceptionRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "RPSaaSMaster",
      },
    },
  ];
  it.each(testCases)(
    "$description",
    async ({ existingLabels, expectedLabelsToAdd, expectedLabelsToRemove, impactAssessment }) => {
      const labelContext = await updateLabels(existingLabels, impactAssessment);

      expect([...labelContext.toAdd].sort()).toEqual(expectedLabelsToAdd.sort());
      expect([...labelContext.toRemove].sort()).toEqual(expectedLabelsToRemove.sort());
    },
  );
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
    async ({ existingLabels, expectedLabelsToAdd, expectedLabelsToRemove }) => {
      /** @type {import("./labelling.js").LabelContext} */
      const labelContext = {
        present: new Set(),
        toAdd: new Set(),
        toRemove: new Set(),
      };
      await processArmReviewLabels(labelContext, existingLabels);

      expect([...labelContext.toAdd].sort()).toEqual(expectedLabelsToAdd.sort());
      expect([...labelContext.toRemove].sort()).toEqual(expectedLabelsToRemove.sort());
    },
  );
});
