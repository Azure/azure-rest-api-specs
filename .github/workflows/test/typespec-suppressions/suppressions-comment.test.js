import { strToU8, zipSync } from "fflate";
import { describe, expect, it } from "vitest";
import { execFile } from "../../../shared/src/exec.js";
import {
  buildSuppressionsComment,
  renderSuppressionsCommentBody,
} from "../../src/typespec-suppressions/suppressions-comment.js";
import { createMockCore, createMockGithub } from "../mocks.js";

const mockCore = createMockCore();

/**
 * @param {object} report
 * @returns {{ data: Buffer }}
 */
function mockArtifactDownload(report) {
  return {
    data: Buffer.from(
      zipSync({
        "typespec-suppressions-report.json": strToU8(JSON.stringify(report)),
      }),
    ),
  };
}

/**
 * @param {import("../mocks.js").MockGithub} github
 * @param {object} [runOverrides]
 */
function mockAnalyzeCodeRun(github, runOverrides = {}) {
  github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
    data: {
      workflow_runs: [
        {
          id: 123,
          name: "TypeSpec Suppressions - Analyze Code",
          status: "completed",
          updated_at: "2025-01-01T00:00:00Z",
          ...runOverrides,
        },
      ],
    },
  });
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: { artifacts: [{ id: 1, name: "typespec-suppressions-report" }] },
  });
}

describe("renderSuppressionsCommentBody", () => {
  const options = {
    owner: "test-owner",
    repo: "test-repo",
    pullNumber: 42,
    isApproved: false,
    runUrl: "https://github.com/test-owner/test-repo/actions/runs/123",
  };

  it("returns undefined when nothing requires approval", () => {
    expect(renderSuppressionsCommentBody({ requiresApproval: false }, options)).toBeUndefined();
  });

  it("renders a heading and the discouraged-suppressions warning", () => {
    const body = renderSuppressionsCommentBody(
      {
        requiresApproval: true,
        newSuppressions: [
          {
            specPath: "specification/demo",
            sourceKind: "inline",
            ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
            justification: "approved for demo",
            sourceFile: "specification/demo/main.tsp",
            anchorPath: "namespace:Demo",
            location: { line: 12, column: 3 },
            rawText: "#suppress",
          },
        ],
      },
      options,
    );

    expect(body).toContain("## TypeSpec suppressions requiring review");
    expect(body).toContain("Suppressions are strongly discouraged");
    expect(body).toContain(
      "❌ Approval required — 1 suppression",
    );
    // Source link text is the file name + line only (full path stays in the href).
    expect(body).toContain(
      '<a href="https://github.com/test-owner/test-repo/pull/42/files#diff-efaa719245fb34e480918c08f8fe8f5b6f620477e1053f1d6f0e2a0ca5f05e69R12">main.tsp#L12</a>',
    );
  });

  it("reflects approval status in the heading and status cells", () => {
    /** @type {import("../../src/typespec-suppressions/suppressions-comment.js").TypeSpecSuppressionsReport} */
    const report = {
      requiresApproval: true,
      newSuppressions: [
        {
          specPath: "specification/demo",
          sourceKind: "inline",
          ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
          justification: "approved for demo",
          sourceFile: "specification/demo/main.tsp",
          anchorPath: "namespace:Demo",
          location: { line: 12, column: 3 },
          rawText: "#suppress",
        },
      ],
    };

    const pending = renderSuppressionsCommentBody(report, {
      ...options,
      isApproved: false,
    });
    expect(pending).toContain(
      "❌ Approval required",
    );
    expect(pending).toContain('<td align="center">❌</td>');

    const approved = renderSuppressionsCommentBody(report, {
      ...options,
      isApproved: true,
    });
    expect(approved).toContain("✅ Approved");
    expect(approved).toContain('<td align="center">✅</td>');
  });
});

describe("buildSuppressionsComment", async () => {
  const unzipExists = await execFile("unzip")
    .then(() => true)
    .catch(() => false);

  it.runIf(unzipExists)(
    "returns a comment body when TypeSpec suppressions require approval",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github);
      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({
          requiresApproval: true,
          newSuppressions: [
            {
              specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
              sourceKind: "inline",
              ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
              justification: "approved for demo",
              sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
              anchorPath: "namespace:Demo/interface:Widgets/op:read",
              location: { line: 12, column: 3 },
              rawText:
                '#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "approved for demo"',
              ruleMetadata: {
                description:
                  "Operations defined using RpcOperation should not have path parameters.",
                documentationUrl:
                  "https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-rpc-path-params",
              },
            },
          ],
          changedSuppressions: [
            {
              before: {
                specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
                sourceKind: "tspconfig",
                ruleName: "@azure-tools/typespec-azure-core/documentation-required",
                justification: "old reason",
                sourceFile:
                  "specification/demo/resource-manager/Microsoft.Demo/Demo/tspconfig.yaml",
                anchorPath:
                  "tspconfig:linter.disable.@azure-tools/typespec-azure-core/documentation-required",
                location: { line: 3, column: 5 },
                rawText: "@azure-tools/typespec-azure-core/documentation-required: old reason",
              },
              after: {
                specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
                sourceKind: "tspconfig",
                ruleName: "@azure-tools/typespec-azure-core/documentation-required",
                justification: "new reason",
                sourceFile:
                  "specification/demo/resource-manager/Microsoft.Demo/Demo/tspconfig.yaml",
                anchorPath:
                  "tspconfig:linter.disable.@azure-tools/typespec-azure-core/documentation-required",
                location: { line: 3, column: 5 },
                rawText: "@azure-tools/typespec-azure-core/documentation-required: new reason",
              },
            },
          ],
        }),
      );

      const body = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        [],
      );

      expect(body).toContain("Approved-TypeSpecSuppression");
      expect(body).toContain(
        "https://github.com/test-owner/test-repo/pull/42/files#diff-58603b41f47740a3dc47d775ed130073a0a767b9e9d23f2725ce1720a38e5df1R12",
      );
      expect(body).toContain("New suppressions (1)");
      expect(body).toContain("Changed suppressions (1)");
      expect(body).toContain(
        "<thead><tr><th>Status</th><th>Rule</th><th>Source</th><th>Previous justification</th><th>New justification</th></tr></thead>",
      );
      expect(body).toContain("Suppressions are strongly discouraged");
      expect(body).toContain("https://aka.ms/tsp-suppress/feedback");
      expect(body).toContain(
        "❌ Approval required — 2 suppressions",
      );
    },
  );

  it.runIf(unzipExists)(
    "renders a bold warning when a suppression justification is missing",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github);
      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({
          requiresApproval: true,
          newSuppressions: [
            {
              specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
              sourceKind: "inline",
              ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
              justification: "",
              sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
              anchorPath: "namespace:Demo/interface:Widgets/op:read",
              location: { line: 12, column: 3 },
              rawText: '#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""',
            },
          ],
        }),
      );

      const body = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        [],
      );

      expect(body).toContain(
        "<strong>NO JUSTIFICATION PROVIDED, THIS IS A REQUIRED SUPPRESSION COMPONENT</strong>",
      );
    },
  );

  it.runIf(unzipExists)(
    "reflects approval status: ❌ pending by default, ✅ when the label is present",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github);
      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({
          requiresApproval: true,
          newSuppressions: [
            {
              specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
              sourceKind: "inline",
              ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
              justification: "approved for demo",
              sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
              anchorPath: "namespace:Demo/interface:Widgets/op:read",
              location: { line: 12, column: 3 },
              rawText:
                '#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "approved for demo"',
            },
          ],
        }),
      );

      const pending = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        [],
      );
      expect(pending).toContain(
        "❌ Approval required",
      );
      expect(pending).toContain('<td align="center">❌</td>');

      const approved = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        ["Approved-TypeSpecSuppression"],
      );
      expect(approved).toContain("✅ Approved");
      expect(approved).toContain('<td align="center">✅</td>');
    },
  );

  it.runIf(unzipExists)(
    "limits the table to 5 suppressions and links to the analysis log",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github, {
        html_url: "https://github.com/test-owner/test-repo/actions/runs/123",
      });

      const newSuppressions = Array.from({ length: 7 }, (_, i) => ({
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "inline",
        ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
        justification: `reason-${i}`,
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
        anchorPath: `namespace:Demo/interface:Widgets/op:read${i}`,
        location: { line: 12 + i, column: 3 },
        rawText: `#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "reason-${i}"`,
      }));

      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({ requiresApproval: true, newSuppressions }),
      );

      const body = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        [],
      );

      // Only the first 5 rows are rendered.
      expect(body).toContain("reason-0");
      expect(body).toContain("reason-4");
      expect(body).not.toContain("reason-5");
      expect(body).not.toContain("reason-6");
      expect(((body ?? "").match(/<td align="center">/g) ?? []).length).toBe(5);
      expect(body).toContain("Showing 5 of 7 suppressions");
      expect(body).toContain(
        '<a href="https://github.com/test-owner/test-repo/actions/runs/123">full analysis log</a>',
      );
    },
  );

  it.runIf(unzipExists)(
    "caps new and changed tables independently at 5 rows each so both render",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github, {
        html_url: "https://github.com/test-owner/test-repo/actions/runs/123",
      });

      /**
       * @param {string} label
       * @param {number} i
       */
      const makeSuppression = (label, i) => ({
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "inline",
        ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
        justification: `${label}-${i}`,
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
        anchorPath: `namespace:Demo/interface:Widgets/op:read${label}${i}`,
        location: { line: 12 + i, column: 3 },
        rawText: `#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "${label}-${i}"`,
      });

      const newSuppressions = Array.from({ length: 7 }, (_, i) => makeSuppression("new", i));
      const changedSuppressions = Array.from({ length: 7 }, (_, i) => ({
        before: makeSuppression("old", i),
        after: makeSuppression("changed", i),
      }));

      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({
          requiresApproval: true,
          newSuppressions,
          changedSuppressions,
        }),
      );

      const body = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        [],
      );

      // Both tables render, each capped at 5 rows (10 status cells total).
      expect(body).toContain("New suppressions (7)");
      expect(body).toContain("Changed suppressions (7)");
      expect(body).toContain("new-4");
      expect(body).not.toContain("new-5");
      expect(body).toContain("changed-4");
      expect(body).not.toContain("changed-5");
      expect(((body ?? "").match(/<td align="center">/g) ?? []).length).toBe(10);
      expect(body).toContain("Showing 10 of 14 suppressions");
    },
  );

  it.runIf(unzipExists)(
    "renders only the checked subset when a check-rules file was used",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github);

      const inScope = {
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "inline",
        ruleName: "@azure-tools/typespec-azure-core/in-scope-rule",
        justification: "in scope",
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
        anchorPath: "namespace:Demo/interface:Widgets/op:read",
        location: { line: 12, column: 3 },
        rawText: '#suppress "@azure-tools/typespec-azure-core/in-scope-rule" "in scope"',
      };
      const outOfScope = {
        ...inScope,
        ruleName: "@azure-tools/typespec-azure-core/out-of-scope-rule",
        justification: "out of scope",
        rawText: '#suppress "@azure-tools/typespec-azure-core/out-of-scope-rule" "out of scope"',
      };

      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({
          // Full diff has both suppressions...
          requiresApproval: true,
          newSuppressions: [inScope, outOfScope],
          changedSuppressions: [],
          // ...but only the in-scope one is checked.
          checkedSuppressions: {
            checkRules: ["@azure-tools/typespec-azure-core/in-scope-rule"],
            requiresApproval: true,
            newSuppressions: [inScope],
            removedSuppressions: [],
            changedSuppressions: [],
          },
        }),
      );

      const body = await buildSuppressionsComment(
        github,
        mockCore,
        "test-owner",
        "test-repo",
        "abc123",
        42,
        [],
      );

      expect(body).toContain("New suppressions (1)");
      expect(body).toContain("in-scope-rule");
      expect(body).not.toContain("out-of-scope-rule");
    },
  );

  it.runIf(unzipExists)(
    "returns undefined when the checked subset is empty even if the full diff has suppressions",
    async () => {
      const github = createMockGithub();
      mockAnalyzeCodeRun(github);
      github.rest.actions.downloadArtifact.mockResolvedValue(
        mockArtifactDownload({
          // Full diff has a suppression, but with an empty ruleset the checked
          // subset is empty, so nothing should be reported.
          requiresApproval: true,
          newSuppressions: [
            {
              specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
              sourceKind: "inline",
              ruleName: "@azure-tools/typespec-azure-core/no-rpc-path-params",
              justification: "not in scope",
              sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
              anchorPath: "namespace:Demo/interface:Widgets/op:read",
              location: { line: 12, column: 3 },
              rawText:
                '#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "not in scope"',
            },
          ],
          changedSuppressions: [],
          checkedSuppressions: {
            checkRules: [],
            requiresApproval: false,
            newSuppressions: [],
            removedSuppressions: [],
            changedSuppressions: [],
          },
        }),
      );

      await expect(
        buildSuppressionsComment(github, mockCore, "test-owner", "test-repo", "abc123", 42, []),
      ).resolves.toBeUndefined();
    },
  );

  it("returns undefined when no completed Analyze Code run is available", async () => {
    const github = createMockGithub();

    // No workflow runs are mocked (createMockGithub defaults to an empty list),
    // so there is no completed Analyze Code run / report artifact to render.
    await expect(
      buildSuppressionsComment(github, mockCore, "test-owner", "test-repo", "abc123", 42, []),
    ).resolves.toBeUndefined();
  });
});
