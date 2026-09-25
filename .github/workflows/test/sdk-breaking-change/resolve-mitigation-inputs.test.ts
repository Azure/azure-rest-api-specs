import { mkdir, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { resolveMitigationTrigger } from "../../src/sdk-breaking-change/resolve-mitigation-inputs.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const temporaryDirectory = join(import.meta.dirname, `results-${crypto.randomUUID()}`);
const analysisResultPath = join(temporaryDirectory, "sdk-breaking-change-analysis.json");

async function writeAnalysisResult(overrides: Record<string, unknown> = {}): Promise<void> {
  await writeFile(
    analysisResultPath,
    JSON.stringify({
      schemaVersion: 1,
      prNumber: 42,
      headSha: "a".repeat(40),
      sdkLanguage: "Java",
      analysisWorkflowUrl: "https://github.com/owner/repo/actions/runs/123",
      status: "success",
      projects: [],
      ...overrides,
    }),
  );
}

beforeEach(async () => {
  await mkdir(temporaryDirectory, { recursive: true });
});

afterEach(async () => {
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("resolveMitigationTrigger", () => {
  it("resolves mitigation inputs from a successful analysis result", async () => {
    await writeAnalysisResult();
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: {
          ref: "feature",
          repo: { full_name: "owner/repo" },
          sha: "a".repeat(40),
        },
      },
    });

    await resolveMitigationTrigger({
      github,
      context,
      core,
      publishedResultsPath: analysisResultPath,
    });

    expect(core.setOutput).toHaveBeenCalledWith("should-run", "true");
    expect(core.setOutput).toHaveBeenCalledWith("pull-number", 42);
    expect(core.setOutput).toHaveBeenCalledWith("sdk-language", "Java");
    expect(core.setOutput).toHaveBeenCalledWith("sdk-repository", "azure-sdk-for-java");
    expect(core.setOutput).toHaveBeenCalledWith("head-repository", "owner/repo");
    expect(core.setOutput).toHaveBeenCalledWith("head-sha", "a".repeat(40));
    expect(core.setOutput).toHaveBeenCalledWith("head-branch", "feature");
  });

  it("skips mitigation when analysis failed", async () => {
    await writeAnalysisResult({
      status: "failure",
      errorMessage: "Analysis failed.",
    });
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();

    await resolveMitigationTrigger({
      github,
      context,
      core,
      publishedResultsPath: analysisResultPath,
    });

    expect(core.notice).toHaveBeenCalledWith("The SDK breaking-change analysis did not succeed.");
    expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("rejects a stale analysis head SHA", async () => {
    await writeAnalysisResult();
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: {
          ref: "feature",
          repo: { full_name: "owner/repo" },
          sha: "b".repeat(40),
        },
      },
    });

    await expect(
      resolveMitigationTrigger({
        github,
        context,
        core,
        publishedResultsPath: analysisResultPath,
      }),
    ).rejects.toThrow("does not match analyzed head");
  });
});
