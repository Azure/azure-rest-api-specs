import { Octokit } from "@octokit/rest";
import { describe, expect, it } from "vitest";
import { processArmReviewLabels } from "../src/summarize-checks/labelling.js";
import {
  createNextStepsComment,
  getCheckRunTuple,
  getExistingLabels,
  updateLabels,
} from "../src/summarize-checks/summarize-checks.js";
import { createMockCore } from "./mocks.js";

const mockCore = createMockCore();

/**
 * Find and extract the "Next Steps to Merge" comment content
 */
async function getNextStepsComment(github, owner, repo, prNumber) {
  try {
    const { data: comments } = await github.rest.issues.listComments({
      owner: owner,
      repo: repo,
      issue_number: prNumber,
    });

    // Find comment containing "Next Steps to Merge"
    const nextStepsComment = comments.find((comment) =>
      comment.body.includes("<h2>Next Steps to Merge</h2>"),
    );

    return nextStepsComment ? nextStepsComment.body : null;
  } catch (error) {
    console.error(`Error getting comments for PR #${prNumber}:`, error.message);
    return null;
  }
}

describe("Summarize Checks Tests", () => {
  describe("next steps comment rendering", () => {
    it("Should generate summary for a mockdata PR scenario", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [
        "Cognitive Services",
        "data-plane",
        "TypeSpec",
        "VersioningReviewRequired",
      ];
      const fyiCheckRuns = [];
      const expectedComment =
        "<h2>Next Steps to Merge</h2>Next steps that must be taken to merge this PR: <br/><ul>" +
        "<li>❌ This PR targets either the <code>main</code> branch of the public specs repo or the <code>RPSaaSMaster</code> branch of the private specs repo. " +
        "These branches are not intended for iterative development. Therefore, you must acknowledge you understand that after this PR is merged, the APIs are considered " +
        "shipped to Azure customers. Any further attempts at in-place modifications to the APIs will be subject to Azure's versioning " +
        "and breaking change policies. <b>Additionally, for control plane APIs, you must acknowledge that you are following all " +
        'the best practices documented by ARM at <a href="https://aka.ms/armapibestpractices">aka.ms/armapibestpractices</a>.</b> ' +
        "If you do intend to release the APIs to your customers by merging this PR, add the <code>PublishToCustomers</code> label " +
        "to your PR in acknowledgement of the above. Otherwise, retarget this PR onto a feature branch, i.e. with prefix <code>release-</code> " +
        '(see <a href="https://aka.ms/azsdk/api-versions#release--branches">aka.ms/azsdk/api-versions#release--branches</a>).</li>' +
        "<li>❌ This PR has at least one change violating Azure versioning policy (label: <code>VersioningReviewRequired</code>).<br/>To unblock this PR, either a) " +
        'introduce a new API version with these changes instead of modifying an existing API version, or b) follow the process at <a href="https://aka.ms/brch">aka.ms/brch</a>.' +
        "</li><li>❌ The required check named <code>TypeSpec Validation</code> has failed. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult " +
        'the <a href="https://aka.ms/ci-fix">aka.ms/ci-fix</a> guide</li></ul>';
      const expectedOutput = [expectedComment, "blocked"];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1000,
            name: "SpellCheck",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1000,
            name: "TypeSpec Requirement",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1000,
            name: "Protected Files",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: {
            precedence: 0,
            name: "TypeSpec Validation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: {
            precedence: 4,
            name: "Swagger BreakingChange",
            suppressionLabels: ["Versioning-Approved-*", "BreakingChange-Approved-*"],
            troubleshootingGuide:
              'To unblock this PR, follow the process at <a href="https://aka.ms/brch">aka.ms/brch</a>.',
          },
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 4,
            name: "Breaking Change(Cross-Version)",
            suppressionLabels: ["Versioning-Approved-*", "BreakingChange-Approved-*"],
            troubleshootingGuide:
              'To unblock this PR, follow the process at <a href="https://aka.ms/brch">aka.ms/brch</a>.',
          },
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1,
            name: "Swagger Avocado",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: {
            precedence: 3,
            name: "Swagger ModelValidation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 2,
            name: "Swagger SemanticValidation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 5,
            name: "Swagger Lint(RPaaS)",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: {
            precedence: 10,
            name: "Automated merging requirements met",
            suppressionLabels: [],
            troubleshootingGuide:
              'This is the final check that must pass. Refer to the check in the PR\'s \'Checks\' tab for details on how to fix it and consult the <a href="https://aka.ms/ci-fix">aka.ms/ci-fix</a> guide. In addition, refer to step 4 in the <a href="https://aka.ms/azsdk/pr-diagram">PR workflow diagram</a>',
          },
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 0,
            name: "license/cla",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1,
            name: "Swagger PrettierCheck",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary for no matched check suites", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const requiredCheckRuns = [];
      const expectedOutput = [
        "<h2>Next Steps to Merge</h2>⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛",
        "pending",
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate success summary for all completed check suites", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const expectedOutput = [
        '<h2>Next Steps to Merge</h2>✅ All automated merging requirements have been met! To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.',
        "success",
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1000,
            name: "SpellCheck",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1000,
            name: "TypeSpec Requirement",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1000,
            name: "Protected Files",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 0,
            name: "TypeSpec Validation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 4,
            name: "Swagger BreakingChange",
            suppressionLabels: ["Versioning-Approved-*", "BreakingChange-Approved-*"],
            troubleshootingGuide:
              'To unblock this PR, follow the process at <a href="https://aka.ms/brch">aka.ms/brch</a>.',
          },
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 4,
            name: "Breaking Change(Cross-Version)",
            suppressionLabels: ["Versioning-Approved-*", "BreakingChange-Approved-*"],
            troubleshootingGuide:
              'To unblock this PR, follow the process at <a href="https://aka.ms/brch">aka.ms/brch</a>.',
          },
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1,
            name: "Swagger Avocado",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 3,
            name: "Swagger ModelValidation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 2,
            name: "Swagger SemanticValidation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 5,
            name: "Swagger Lint(RPaaS)",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 10,
            name: "Automated merging requirements met",
            suppressionLabels: [],
            troubleshootingGuide:
              'This is the final check that must pass. Refer to the check in the PR\'s \'Checks\' tab for details on how to fix it and consult the <a href="https://aka.ms/ci-fix">aka.ms/ci-fix</a> guide. In addition, refer to step 4 in the <a href="https://aka.ms/azsdk/pr-diagram">PR workflow diagram</a>',
          },
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 0,
            name: "license/cla",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: {
            precedence: 1,
            name: "Swagger PrettierCheck",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when checks are in progress", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const expectedOutput = [
        "<h2>Next Steps to Merge</h2>⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛",
        "pending",
      ];

      const requiredCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: {
            precedence: 0,
            name: "TypeSpec Validation",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "Swagger Avocado",
          status: "QUEUED",
          conclusion: null,
          checkInfo: {
            precedence: 1,
            name: "Swagger Avocado",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: {
            precedence: 0,
            name: "license/cla",
            suppressionLabels: [],
            troubleshootingGuide:
              "Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the <a href=\"https://aka.ms/ci-fix\">aka.ms/ci-fix</a> guide",
          },
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
      );

      expect(output).toEqual(expectedOutput);
    });
  });

  describe("integration test", () => {
    it.skipIf(!process.env.GITHUB_TOKEN || !process.env.INTEGRATION_TEST)(
      "Should fetch real pr data and check the next steps to merge and final labels against what is actually there.",
      async () => {
        const issue_number = 36258;
        const owner = "Azure";
        const repo = "azure-rest-api-specs";

        const ignorableLabels = [
          "VersioningReviewRequired",
          "BreakingChangeReviewRequired",
          "customer-reported",
          "dependencies",
          "javascript",
          "Monitor",
        ];

        const github = new Octokit({
          auth: process.env.GITHUB_TOKEN,
        });

        const { data: pr } = await github.rest.pulls.get({
          owner: owner,
          repo: repo,
          pull_number: issue_number,
        });

        // Get current PR labels and Next Steps comment
        const expectedNextStepsComment = await getNextStepsComment(
          github,
          owner,
          repo,
          issue_number,
        );

        const head_sha = pr.head.sha;
        const expectedLabels = await getExistingLabels(github, owner, repo, issue_number);

        const [requiredCheckRuns, fyiCheckRuns, impactAssessment] = await getCheckRunTuple(
          github,
          mockCore,
          owner,
          repo,
          head_sha,
          issue_number,
          [],
        );

        let adjustedStartLabels = expectedLabels.filter((x) => ignorableLabels.includes(x));
        let labelContext = await updateLabels(adjustedStartLabels, impactAssessment);

        adjustedStartLabels = adjustedStartLabels.filter(
          (name) => !labelContext.toRemove.has(name),
        );
        for (const label of labelContext.toAdd) {
          if (!adjustedStartLabels.includes(label)) {
            adjustedStartLabels.push(label);
          }
        }

        const [commentBody, automatedChecksMet] = await createNextStepsComment(
          mockCore,
          repo,
          adjustedStartLabels,
          pr.base.ref,
          requiredCheckRuns,
          fyiCheckRuns,
        );

        const actualLabels = [...labelContext.toAdd, ...labelContext.present];
        expect(actualLabels.sort()).toEqual(expectedLabels.sort());
        expect(commentBody).toEqual(expectedNextStepsComment);
        expect(automatedChecksMet).toBeTruthy();
      },
      600000,
    );
  });

  describe("label add and remove", () => {
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
});
