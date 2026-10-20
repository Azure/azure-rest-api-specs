import { mkdir, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { AnalysisResult } from "../../src/sdk-breaking-change/types.ts";
import {
  buildAnalysisReport,
  publishAnalysisResult,
} from "../../src/sdk-breaking-change/publish-analysis-result.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const analyzedSha = "6fb74c85cd16a8e13d4ad1aca058993cd076fa8b";
const analysisWorkflowUrl = "https://github.com/owner/repo/actions/runs/123";
let resultsPath: string;
let analysisResult: AnalysisResult;

beforeEach(async () => {
  resultsPath = join(import.meta.dirname, `results-${crypto.randomUUID()}`);
  await mkdir(resultsPath, { recursive: true });
  analysisResult = {
    schemaVersion: 1,
    prNumber: 42,
    headSha: analyzedSha,
    sdkLanguage: "Go",
    analysisWorkflowUrl,
    status: "success",
    projects: [
      {
        typespecProject: "specification/service/Widget.Service",
        sdkPackage: "armwidget",
        analysisStatus: "success",
        breakingChanges: [
          {
            id: "model-change",
            breakingChange: "Model changed",
            category: "spec change",
            suggestedFix: "Restore the old shape",
          },
          {
            id: "property-change",
            breakingChange: "Property changed",
            category: "spec change",
            suggestedFix: "",
          },
        ],
      },
    ],
  };
  await writeFile(
    join(resultsPath, "sdk-breaking-change-analysis.json"),
    JSON.stringify(analysisResult),
  );
  vi.stubEnv("RESULTS_PATH", resultsPath);
});

afterEach(async () => {
  vi.unstubAllEnvs();
  await rm(resultsPath, { recursive: true, force: true });
});

describe("buildAnalysisReport", () => {
  it.each(["skipped", "failure"] as const)(
    "preserves a project with analysis status %s and no generated package",
    async (analysisStatus) => {
      analysisResult.projects = [
        {
          typespecProject: "specification/service/Widget.Service",
          sdkPackage: "",
          analysisStatus,
          breakingChanges: [],
        },
      ];
      await writeFile(
        join(resultsPath, "sdk-breaking-change-analysis.json"),
        JSON.stringify(analysisResult),
      );

      const { result } = await buildAnalysisReport(resultsPath);

      expect(result.projects).toEqual(analysisResult.projects);
    },
  );

  it("rejects a successful analysis project without a package name", async () => {
    analysisResult.projects[0].sdkPackage = "";
    await writeFile(
      join(resultsPath, "sdk-breaking-change-analysis.json"),
      JSON.stringify(analysisResult),
    );

    await expect(buildAnalysisReport(resultsPath)).rejects.toThrow(
      "Successful analysis requires an SDK package name.",
    );
  });

  it("builds the command and report from downloaded results", async () => {
    const result = await buildAnalysisReport(resultsPath);

    expect(result.command).toBe("/azsdk sdk-breaking-analysis Go");
    expect(result.report).toContain(`**Analyzed commit:** \`${analyzedSha}\``);
    expect(result.report).toContain(
      `[SDK breaking change analysis details](${analysisWorkflowUrl}#armwidget-breaking-change)`,
    );
    expect(result.report).toContain("| ID | Breaking change | Category | Suggested fix |");
    expect(result.report).toContain(
      "| model-change | Model changed | spec change | Restore the old shape |",
    );
    expect(result.report).toContain("| property-change | Property changed | spec change |  |");
  });
});

describe("publishAnalysisResult", () => {
  it("publishes a current analysis result", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: analyzedSha } } });
    const core = createMockCore();

    await publishAnalysisResult({
      github,
      context: createMockContext(),
      core,
    });

    expect(github.rest.issues.createComment).toHaveBeenCalled();
    const comment = github.rest.issues.createComment.mock.calls[0]?.[0] as {
      issue_number: number;
      body: string;
    };
    expect(comment.issue_number).toBe(42);
    expect(comment.body).toMatch(/^\/azsdk sdk-breaking-analysis Go\n\n/);
    expect(comment.body).toContain(`<!-- sdk-breaking-change-head-sha: ${analyzedSha} -->`);
    expect(core.setOutput).toHaveBeenCalledWith("issue_number", 42);
    expect(core.setOutput).toHaveBeenCalledWith("head_sha", analyzedSha);
  });

  it("publishes the error message for a failed analysis", async () => {
    analysisResult.status = "failure";
    analysisResult.errorMessage = "SDK generation failed.";
    await writeFile(
      join(resultsPath, "sdk-breaking-change-analysis.json"),
      JSON.stringify(analysisResult),
    );
    const github = createMockGithub();
    const core = createMockCore();

    await publishAnalysisResult({ github, context: createMockContext(), core });

    const errorMessage = [
      "SDK breaking-change analysis failed.",
      "",
      "SDK generation failed.",
      "",
      `[See analysis workflow](${analysisWorkflowUrl})`,
    ].join("\n");
    expect(core.warning).toHaveBeenCalledWith(errorMessage);
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        issue_number: 42,
        body: [
          `/azsdk sdk-breaking-analysis Go`,
          "",
          `❌ ${errorMessage}`,
          `<!-- sdk-breaking-change-head-sha: ${analyzedSha} -->`,
          "<!-- /azsdk sdk-breaking-analysis Go -->",
        ].join("\n"),
      }),
    );
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("publishes a stale analysis warning", async () => {
    const github = createMockGithub();
    const currentSha = "a".repeat(40);
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: currentSha } } });
    const core = createMockCore();

    await publishAnalysisResult({ github, context: createMockContext(), core });

    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("is stale"));
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        issue_number: 42,
        body: [
          "/azsdk sdk-breaking-analysis Go",
          "",
          `⚠️ Analysis result for ${analyzedSha} is stale; current PR head is ${currentSha}.`,
          `<!-- sdk-breaking-change-head-sha: ${analyzedSha} -->`,
          "<!-- /azsdk sdk-breaking-analysis Go -->",
        ].join("\n"),
      }),
    );
  });
});
