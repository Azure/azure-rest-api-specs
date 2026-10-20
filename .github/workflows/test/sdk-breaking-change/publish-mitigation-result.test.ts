import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { marked } from "marked";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import {
  buildMitigationReport,
  publishMitigationResult,
} from "../../src/sdk-breaking-change/publish-mitigation-result.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

let resultsPath: string;
let mitigationResultPath: string;

const applyGuidance =
  "<p>💡 Apply Mitigation: Apply the customization code to mitigate the breaking changes.</p>";
const workflowSummaryUrl = "https://github.com/owner/repo/actions/runs/456";
const suppressionGuidance =
  "<p>💡 Suppress Breaking Changes: For accepted breaking changes, click the breaking change ID link to view suppression instructions and follow the suppression process.</p>";

beforeEach(async () => {
  resultsPath = join(import.meta.dirname, `results-${crypto.randomUUID()}`);
  mitigationResultPath = join(resultsPath, "sdk-breaking-change-mitigation.json");
  await mkdir(resultsPath, { recursive: true });
  await writeFile(
    mitigationResultPath,
    JSON.stringify({
      schemaVersion: 1,
      prNumber: 42,
      headSha: "a".repeat(40),
      sdkLanguage: "Java",
      mitigationWorkflowUrl: "https://github.com/owner/repo/actions/runs/456",
      status: "success",
      customizationCode: "+customization",
      projects: [
        {
          typespecProject: "specification/service/Widget.Service",
          sdkPackage: "armwidget",
          breakingChanges: [
            {
              id: "model-change",
              breakingChange: "Model changed",
              suggestedFix: "Restored compatibility",
              isResolved: true,
              typespecChangesSummary: ["Added client customization"],
            },
            {
              id: "property-change",
              breakingChange: "Property changed",
              suggestedFix: "Restore the old property",
              isResolved: false,
            },
          ],
        },
      ],
    }),
  );
});

afterEach(async () => {
  await rm(resultsPath, { recursive: true, force: true });
});

describe("buildMitigationReport", () => {
  it("combines resolved and unresolved changes in one expanded table", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    const { report } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(report).toContain("## SDK Breaking Change Mitigation for Java");
    expect(report).toContain("**TypeSpec project:** specification/service/Widget.Service");
    expect(report).toContain(
      `| ✔️ | [model-change](${workflowSummaryUrl}#breaking-change-model-change-breaking-change "How to Suppress") | Model changed | Restored compatibility | Added client customization |`,
    );
    expect(report).toContain(
      `| ❌ | [property-change](${workflowSummaryUrl}#breaking-change-property-change-breaking-change "How to Suppress") | Property changed | Restore the old property |  |`,
    );
    expect(report).toContain("````diff\n+customization\n````");
    expect(report).toContain(
      "<details><summary>View customization Code</summary>\n\n````diff\n+customization\n````\n\n</details>",
    );
    expect(report).toContain(
      "<details open><summary>View breaking changes</summary>\n\n| Resolvable | ID | Breaking change | Resolution | TypeSpec changes |",
    );
    expect(report.match(/\| Resolvable \| ID \|/g)).toHaveLength(1);
    for (const id of ["model-change", "property-change"]) {
      expect(marked.parse(report)).toContain(
        `<a href="${workflowSummaryUrl}#breaking-change-${id}-breaking-change" title="How to Suppress">${id}</a>`,
      );
    }
    expect(report).not.toContain("**Resolved Breaking Changes:**");
    expect(report).not.toContain("**Unresolved Breaking Changes:**");
    expect(report).toContain(
      `[View customization code in the workflow summary](https://github.com/owner/repo/actions/runs/456)\n\n## Next Steps\n\n${applyGuidance}\n\n${suppressionGuidance}`,
    );
    expect(marked.parse(report)).toContain("<h2>Next Steps</h2>");
    expect(report).toContain("</details>\n\n[View customization code in the workflow summary]");
    expect(marked.parse(report)).toContain(
      '<a href="https://github.com/owner/repo/actions/runs/456">View customization code in the workflow summary</a>',
    );
  });

  it("keeps the no-changes message outside a collapsible block", async () => {
    const artifact = JSON.parse(await readFile(mitigationResultPath, "utf8")) as Record<
      string,
      unknown
    >;
    await writeFile(
      mitigationResultPath,
      JSON.stringify({ ...artifact, customizationCode: " \n " }),
    );
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    const { report } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(report).toContain("No mitigation changes were produced.");
    expect(report).not.toContain("<details>");
    expect(report).toContain(`## Next Steps\n\n${applyGuidance}\n\n${suppressionGuidance}`);
    expect(report).toContain(applyGuidance);
    expect(report).toContain(suppressionGuidance);
  });

  it.each(["failure", "stale"] as const)(
    "omits customization and action guidance for a %s result",
    async (kind) => {
      const github = createMockGithub();
      const core = createMockCore();
      if (kind === "failure") {
        const artifact = JSON.parse(await readFile(mitigationResultPath, "utf8")) as Record<
          string,
          unknown
        >;
        await writeFile(
          mitigationResultPath,
          JSON.stringify({ ...artifact, status: "failure", errorMessage: "Customization failed" }),
        );
      } else {
        github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "b".repeat(40) } } });
      }

      const { report } = await buildMitigationReport({
        github,
        context: createMockContext(),
        core,
        mitigationResultPath,
        workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
      });

      expect(report).toContain(kind === "failure" ? "Customization failed" : "is stale;");
      expect(report).not.toContain("**Customization Code:**");
      expect(report).not.toContain("<details");
      expect(report).not.toContain("## Next Steps");
      expect(report).not.toContain(applyGuidance);
      expect(report).not.toContain(suppressionGuidance);
      expect(core.warning).toHaveBeenCalledOnce();
      if (kind === "failure") expect(github.rest.pulls.get).not.toHaveBeenCalled();
    },
  );

  it("includes the full customization code even beyond 12,000 characters", async () => {
    const customizationCode = `+${"a".repeat(12_000)}`;
    const artifact = JSON.parse(await readFile(mitigationResultPath, "utf8")) as Record<
      string,
      unknown
    >;
    await writeFile(mitigationResultPath, JSON.stringify({ ...artifact, customizationCode }));
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    const { report, result } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(report).toContain(`\`\`\`\`diff\n${customizationCode}\n\`\`\`\``);
    expect(report).not.toContain("diff truncated.");
    expect(result.customizationCode).toBe(customizationCode);
  });

  it("renders a success icon when all breaking changes are resolved", async () => {
    const artifact = JSON.parse(await readFile(mitigationResultPath, "utf8")) as {
      projects: Array<{ breakingChanges: Array<{ isResolved: boolean }> }>;
    };
    artifact.projects[0].breakingChanges = artifact.projects[0].breakingChanges.filter(
      ({ isResolved }) => isResolved,
    );
    await writeFile(mitigationResultPath, JSON.stringify(artifact));
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    const { report } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(report).toContain(
      `| ✔️ | [model-change](${workflowSummaryUrl}#breaking-change-model-change-breaking-change "How to Suppress") |`,
    );
    expect(report).not.toContain("| ❌ |");
  });

  it("renders an error icon when no breaking changes are resolved", async () => {
    const artifact = JSON.parse(await readFile(mitigationResultPath, "utf8")) as {
      projects: Array<{ breakingChanges: Array<{ isResolved: boolean }> }>;
    };
    artifact.projects[0].breakingChanges = artifact.projects[0].breakingChanges.filter(
      ({ isResolved }) => !isResolved,
    );
    await writeFile(mitigationResultPath, JSON.stringify(artifact));
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    const { report } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(report).toContain(
      `| ❌ | [property-change](${workflowSummaryUrl}#breaking-change-property-change-breaking-change "How to Suppress") |`,
    );
    expect(report).not.toContain("| ✔️ |");
  });

  it("displays None without a table when the project has no breaking changes", async () => {
    const artifact = JSON.parse(await readFile(mitigationResultPath, "utf8")) as {
      projects: Array<{ breakingChanges: unknown[] }>;
    };
    artifact.projects[0].breakingChanges = [];
    await writeFile(mitigationResultPath, JSON.stringify(artifact));
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });
    const { report } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });
    expect(report).toContain("**Breaking Changes:**\n\nNone");
    expect(report).not.toContain("| Resolvable |");
    expect(report).not.toContain("<details open>");
  });
});

describe("publishMitigationResult", () => {
  it("publishes using the language-specific mitigation command", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });
    const core = createMockCore();

    await publishMitigationResult({
      github,
      context: createMockContext(),
      core,
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(github.rest.issues.createComment).toHaveBeenCalled();
    const comment = github.rest.issues.createComment.mock.calls[0]?.[0] as {
      issue_number: number;
      body: string;
    };
    expect(comment.issue_number).toBe(42);
    expect(comment.body).toMatch(/^\/azsdk sdk-breaking-mitigate Java\n\n/);
    expect(comment.body).toContain(`<!-- sdk-breaking-change-head-sha: ${"a".repeat(40)} -->`);
    expect(comment.body).toContain("<!-- /azsdk sdk-breaking-mitigate Java -->");
    expect(comment.body).toContain(applyGuidance);
    expect(comment.body).toContain(suppressionGuidance);
    expect(comment.body).toContain(`## Next Steps\n\n${applyGuidance}\n\n${suppressionGuidance}`);
    expect(comment.body).toContain(
      `[model-change](${workflowSummaryUrl}#breaking-change-model-change-breaking-change "How to Suppress")`,
    );
    expect(core.setOutput).toHaveBeenCalledWith("issue_number", 42);
    expect(core.setOutput).toHaveBeenCalledWith("head_sha", "a".repeat(40));
  });
});
