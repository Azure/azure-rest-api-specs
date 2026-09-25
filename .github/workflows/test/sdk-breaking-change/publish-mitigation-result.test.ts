import { mkdir, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import {
  buildMitigationReport,
  publishMitigationResult,
} from "../../src/sdk-breaking-change/publish-mitigation-result.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

let resultsPath: string;
let mitigationResultPath: string;

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
              breakingChange: "Model changed",
              suggestedFix: "Restored compatibility",
              isResolved: true,
              typespecChangesSummary: ["Added client customization"],
            },
            {
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
  it("builds resolved and unresolved mitigation sections", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    const { report } = await buildMitigationReport({
      github,
      context: createMockContext(),
      core: createMockCore(),
      mitigationResultPath,
      workflowSummaryUrl: "https://github.com/owner/repo/actions/runs/456",
    });

    expect(report).toContain("**TypeSpec project:** specification/service/Widget.Service");
    expect(report).toContain(
      "| Model changed | Restored compatibility | Added client customization |",
    );
    expect(report).toContain("| Property changed | Restore the old property |");
    expect(report).toContain("````diff\n+customization\n````");
  });
});

describe("publishMitigationResult", () => {
  it("publishes using the language-specific mitigation command", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    await publishMitigationResult({
      github,
      context: createMockContext(),
      core: createMockCore(),
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
  });
});
