import { Octokit } from "@octokit/rest";
import { describe, expect, it } from "vitest";
import { processArmReviewLabels } from "../../src/summarize-checks/labelling.js";
import {
  createNextStepsComment,
  extractRunsFromGraphQLResponse,
  getCheckInfo,
  getCheckRunTuple,
  getExistingLabels,
  updateLabels,
} from "../../src/summarize-checks/summarize-checks.js";
import { createMockCore } from "../mocks.js";

const mockCore = createMockCore();

/**
 * Find and extract the "Next Steps to Merge" existing comment on a PR.
 * Used in the integration test.
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

// find and extract the existing "Automated merging requirements met" check run from the PR
async function getExistingAMR(github, owner, repo, sha) {
  const { data: checkSuites } = await github.rest.checks.listSuitesForRef({
    owner: owner,
    repo: repo,
    ref: sha,
  });

  for (const suite of checkSuites.check_suites) {
    const { data: checkRuns } = await github.rest.checks.listForSuite({
      owner: owner,
      repo: repo,
      check_suite_id: suite.id,
    });

    for (const run of checkRuns.check_runs) {
      if (run.name === "Automated merging requirements met") {
        return {
          name: run.name,
          status: run.status,
          conclusion: run.conclusion,
        };
      }
    }
  }
}

async function applicableLabel(input) {
  const applicableLabels = [
    "ARMReview",
    "new-api-version",
    "resource-manager",
    "data-plane",
    "TypeSpec",
    "RPaaS",
    "new-rp-namespace",
    "RPaaSException",
    "NotReadyForARMReview",
    "WaitForARMFeedback",
    "ARMChangesRequested",
    "ARMSignedOff",
  ]

  return applicableLabels.includes(input);
}

describe("Summarize Checks Integration Tests", () => {
  describe("Repro a PR summarize-checks invocation", () => {
    const testCases = [
      36439,
      36437,
      36436,
      36435,
      36434,
      36433,
      36432,
      36431,
      36430,
      36429,
      36428,
      36427,
      36426,
      36425,
      36424,
      36423,
      36422,
      36421,
      36420,
      36419,
      36417,
      36416,
      36415,
      36414,
      36413,
      36412,
      36406,
      36402,
      36397,
      36394,
      36392,
      36375,
      36374,
      36362,
      36358,
      36357,
      36350,
      36334,
      36324,
      36301,
      36292,
      36290,
      36280,
      36277,
      36263,
      36219,
      36218,
      36211,
      36207,
      36201,
      36171,
      36115,
      36100,
      36084,
      36074,
      36063,
      36062,
      36056,
      36055,
      36045,
      36043,
      36039,
      36038,
      36002,
      35995,
      35993,
      35984,
      35981,
      35977,
      35976,
      35974,
      35967,
      35966,
      35945,
      35942,
      35938,
      35914,
      35905,
      35895,
      35884,
      35880,
      35878,
      35876,
      35868,
      35846,
      35842,
      35834,
      35832,
      35769,
      35757,
      35728,
      35680,
      35672,
      35669,
      35632,
      35628,
      35627,
      35574,
      35559,
      35550,
      35535,
      35531,
      35471,
      35466,
      35455,
      35446,
      35440,
      35416,
      35403,
      35369,
      35320,
      35239,
      35105,
      34856,
      34326,
      34319,
      34311,
      33936,
      32527,
      30902,
      22009,
      16169,
      15872,
      13684
    ]

    it.skipIf(!process.env.GITHUB_TOKEN || !process.env.INTEGRATION_TEST).each(testCases)(
      "Should fetch real pr data and check the next steps to merge and final labels against what is actually there.",
      async (issue_number) => {
        const owner = "Azure";
        const repo = "azure-rest-api-specs";

        const github = new Octokit({
          auth: process.env.GITHUB_TOKEN,
        });

        const { data: pr } = await github.rest.pulls.get({
          owner: owner,
          repo: repo,
          pull_number: issue_number,
        });

        const head_sha = pr.head.sha;
        const expectedLabels = await getExistingLabels(github, owner, repo, issue_number);
        const expectedCheckRun = await getExistingAMR(github, owner, repo, head_sha);
        const expectedNextStepsComment = await getNextStepsComment(github, owner, repo, issue_number);
        const [requiredCheckRuns, fyiCheckRuns, impactAssessment] = await getCheckRunTuple(
          github,
          mockCore,
          owner,
          repo,
          head_sha,
          issue_number,
          [],
        );

        // discard everything from start set that would be possibly set by summarize-checks
        let adjustedStartLabels = expectedLabels.filter((x) => !applicableLabel(x));
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
          impactAssessment !== undefined
        );

        const actualLabels = [...labelContext.toAdd, ...labelContext.present];
        expect(actualLabels.sort()).toEqual(expectedLabels.sort());
        expect(commentBody).toEqual(expectedNextStepsComment);
        expect(automatedChecksMet.result).toEqual(expectedCheckRun.conclusion.toUpperCase());
      },
      600000,
    );
  });
});

describe("Summarize Checks Unit Tests", () => {
  describe("check result processing", () => {
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
      const expectedOutput = [
        expectedComment,
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "FAILURE",
          summary:
            "❌ This PR cannot be merged because some requirements are not met. See the details.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Lint(RPaaS)"),
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Automated merging requirements met"),
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate completed summary for no matched check suites", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const requiredCheckRuns = [];
      const expectedOutput = [
        '<h2>Next Steps to Merge</h2>✅ All automated merging requirements have been met! To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.',
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.<br/>To merge this PR, refer to <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.<br/>For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
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
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.<br/>To merge this PR, refer to <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.<br/>For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Lint(RPaaS)"),
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Automated merging requirements met"),
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when impact assessment is not completed", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const expectedOutput = [
        "<h2>Next Steps to Merge</h2>⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛",
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Lint(RPaaS)"),
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Automated merging requirements met"),
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        false, // assessmentCompleted
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
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
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
        true, // assessmentCompleted
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate completed summary with completed required checks but in-progress FYI", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const expectedOutput = [
        '<h2>Next Steps to Merge</h2>✅ All automated merging requirements have been met! To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.',
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.<br/>To merge this PR, refer to <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.<br/>For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
      ];

      const fyiCheckRuns = [
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
        true, // assessmentCompleted
      );

      expect(output).toEqual(expectedOutput);
    });

    // this case should NEVER occur in practice, due to Summarize PR Impact being made a "required" check, but in cases
    // where the user is targeting a branch that is not the main branch, we may have no required checks
    // but still have FYI checks in progress. This is a regression test to ensure we handle this case correctly.
    it("should generate completed summary with 0 required checks but in-progress FYI", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const expectedOutput = [
        '<h2>Next Steps to Merge</h2>✅ All automated merging requirements have been met! To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.',
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.<br/>To merge this PR, refer to <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.<br/>For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const requiredCheckRuns = [];

      const fyiCheckRuns = [
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
        true, // assessmentCompleted
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when checks are partially in progress", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const expectedOutput = [
        "<h2>Next Steps to Merge</h2>⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛",
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("license/cla"),
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
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
        {
          name: "[TEST-IGNORE] Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger Avocado",
          status: "QUEUED",
          conclusion: null,
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("license/cla"),
        },
      ];

      const output = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate error summary with a failed required check, and in-progress FYI checks", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const expectedCheckOutput = {
        name: "[TEST-IGNORE] Automated merging requirements met",
        result: "FAILURE",
        summary:
          "❌ This PR cannot be merged because some requirements are not met. See the details.",
      };

      const fyiCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
      ];

      const requiredCheckRuns = [
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
      ];

      const [, automatedCheckOutput] = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
      );

      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
    });

    it("should generate error summary when checks are in error state", async () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [];
      const fyiCheckRuns = [];
      const expectedCheckOutput = {
        name: "[TEST-IGNORE] Automated merging requirements met",
        result: "FAILURE",
        summary:
          "❌ This PR cannot be merged because some requirements are not met. See the details.",
      };

      const requiredCheckRuns = [
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
      ];

      const [, automatedCheckOutput] = await createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
      );

      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
    });

    it("should extract check info from raw check response data", async () => {
      const expectedCheckRunId = 16582733356;
      const response = await import("./fixtures/RawGraphQLResponse.json", {
        assert: { type: "json" },
      });
      const [requiredCheckRuns, fyiCheckRuns, impactAssessmentWorkflowId] =
        await extractRunsFromGraphQLResponse(response);

      expect(requiredCheckRuns).toBeDefined();
      expect(fyiCheckRuns).toBeDefined();
      expect(impactAssessmentWorkflowId).toBeDefined();
      expect(requiredCheckRuns.length).toEqual(11);
      expect(fyiCheckRuns.length).toEqual(0);
      expect(impactAssessmentWorkflowId).toEqual(expectedCheckRunId);
    });
  });

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
        description: "We shouldn't add ARM review if resourceManagerRequired is false",
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
});
