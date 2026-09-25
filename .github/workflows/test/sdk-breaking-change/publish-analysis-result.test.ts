import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  AnalysisResultSchema,
  createAnalysisResult,
} from "../../src/sdk-breaking-change/create-analysis-result.ts";
import {
  buildAnalysisReport,
  publishAnalysisResult,
} from "../../src/sdk-breaking-change/publish-analysis-result.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const analyzedSha = "6fb74c85cd16a8e13d4ad1aca058993cd076fa8b";
const analysisWorkflowUrl = "https://github.com/owner/repo/actions/runs/123";
let resultsPath: string;

beforeEach(async () => {
  resultsPath = join(import.meta.dirname, `results-${crypto.randomUUID()}`);
  await mkdir(join(resultsPath, "package"), { recursive: true });
  await writeFile(
    join(resultsPath, "projects.json"),
    JSON.stringify([
      {
        typespecProjectPath: "specification/service/Widget.Service",
        packageName: "armwidget",
        resultsPath: "package",
      },
    ]),
  );
  await writeFile(
    join(resultsPath, "package", "breaking-changes.json"),
    JSON.stringify({
      result: {
        breakingChanges: [
          {
            breakingChange: "Model changed",
            category: "spec change",
            resolution: "Restore the old shape",
          },
          {
            breakingChange: "Property changed",
            category: "spec change",
            resolution: null,
          },
        ],
      },
    }),
  );
  await createAnalysisResult({
    resultsPath,
    prNumber: 42,
    headSha: analyzedSha,
    sdkLanguage: "Go",
    analysisWorkflowUrl,
    status: "success",
  });
  vi.stubEnv("RESULTS_PATH", resultsPath);
});

afterEach(async () => {
  vi.unstubAllEnvs();
  await rm(resultsPath, { recursive: true, force: true });
});

describe("createAnalysisResult", () => {
  it("creates a versioned artifact from raw analysis results", async () => {
    const artifact = AnalysisResultSchema.parse(
      JSON.parse(await readFile(join(resultsPath, "sdk-breaking-change-analysis.json"), "utf8")),
    );

    expect(artifact).toEqual({
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
          breakingChanges: [
            {
              breakingChange: "Model changed",
              category: "spec change",
              suggestedFix: "Restore the old shape",
            },
            {
              breakingChange: "Property changed",
              category: "spec change",
              suggestedFix: "",
            },
          ],
        },
      ],
    });
  });

  it("includes the error message for a failed analysis", async () => {
    const failureResultsPath = join(resultsPath, "failure");
    await mkdir(failureResultsPath);
    await writeFile(join(failureResultsPath, "error.log"), "Analysis failed with exit code 1.\n");

    const artifact = await createAnalysisResult({
      resultsPath: failureResultsPath,
      prNumber: 42,
      headSha: analyzedSha,
      sdkLanguage: "Go",
      analysisWorkflowUrl,
      status: "failure",
    });

    expect(artifact.errorMessage).toBe(
      `Analysis failed with exit code 1.\n\n[See analysis workflow](${analysisWorkflowUrl})`,
    );
  });

  it("uses a fallback error message when no failure log exists", async () => {
    const artifact = await createAnalysisResult({
      resultsPath: join(resultsPath, "setup-failure"),
      prNumber: 42,
      headSha: analyzedSha,
      sdkLanguage: "Go",
      analysisWorkflowUrl,
      status: "failure",
    });

    expect(artifact.errorMessage).toBe(
      `SDK breaking-change analysis failed.\n\n[See analysis workflow](${analysisWorkflowUrl})`,
    );
  });
});

describe("buildAnalysisReport", () => {
  it("builds the command and report from downloaded results", async () => {
    const result = await buildAnalysisReport(resultsPath);

    expect(result.command).toBe("/azsdk sdk-breaking-analysis Go");
    expect(result.report).toContain(`**Analyzed commit:** \`${analyzedSha}\``);
    expect(result.report).toContain(
      `[SDK breaking change analysis details](${analysisWorkflowUrl})`,
    );
    expect(result.report).toContain("| ☐ | Model changed | spec change | Restore the old shape |");
  });
});

describe("publishAnalysisResult", () => {
  it("publishes a current analysis result", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: analyzedSha } } });

    await publishAnalysisResult({
      github,
      context: createMockContext(),
      core: createMockCore(),
    });

    expect(github.rest.issues.createComment).toHaveBeenCalled();
    const comment = github.rest.issues.createComment.mock.calls[0]?.[0] as {
      issue_number: number;
      body: string;
    };
    expect(comment.issue_number).toBe(42);
    expect(comment.body).toMatch(/^\/azsdk sdk-breaking-analysis Go\n\n/);
  });

  it("publishes the error message for a failed analysis", async () => {
    await writeFile(join(resultsPath, "error.log"), "SDK generation failed.\n");
    await createAnalysisResult({
      resultsPath,
      prNumber: 42,
      headSha: analyzedSha,
      sdkLanguage: "Go",
      analysisWorkflowUrl,
      status: "failure",
    });
    const github = createMockGithub();
    const core = createMockCore();

    await publishAnalysisResult({ github, context: createMockContext(), core });

    const errorMessage = `SDK generation failed.\n\n[See analysis workflow](${analysisWorkflowUrl})`;
    expect(core.warning).toHaveBeenCalledWith(errorMessage);
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        issue_number: 42,
        body: `/azsdk sdk-breaking-analysis Go\n\n${errorMessage}`,
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
          `Analysis result for ${analyzedSha} is stale; current PR head is ${currentSha}.`,
        ].join("\n"),
      }),
    );
  });
});
