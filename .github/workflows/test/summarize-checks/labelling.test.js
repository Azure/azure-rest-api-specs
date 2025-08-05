import { describe, expect, it } from "vitest";
import { processArmReviewLabels } from "../../src/summarize-checks/labelling.js";

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
