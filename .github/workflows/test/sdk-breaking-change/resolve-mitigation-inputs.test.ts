import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { zipSync } from "fflate";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

import { resolveMitigationTrigger } from "../../src/sdk-breaking-change/resolve-mitigation-inputs.ts";
import { createMockContext, createMockCore, createMockGithub, type MockGithub } from "../mocks.ts";

const temporaryDirectory = join(import.meta.dirname, `results-${crypto.randomUUID()}`);
const analysisResultPath = join(temporaryDirectory, "sdk-breaking-change-analysis.json");
const analysisStatusPath = join(temporaryDirectory, "analysis-status", "run");
const analysisArtifactName = "sdk-breaking-change-results";
const analysisStatusArtifactName = "sdk-breaking-change-analysis-status";
const mitigationStatusPath = join(temporaryDirectory, "mitigation-status", "run");
const workflowRunId = 456;

function mockArtifactDownloads(github: MockGithub): void {
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: {
      artifacts: [
        { id: 122, name: analysisStatusArtifactName },
        { id: 123, name: analysisArtifactName },
      ],
    },
  });
  github.rest.actions.downloadArtifact.mockImplementation(async ({ artifact_id }) => {
    const isStatus = artifact_id === 122;
    const contents = await readFile(isStatus ? analysisStatusPath : analysisResultPath);
    const archive = zipSync({
      [isStatus ? "run" : "sdk-breaking-change-analysis.json"]: contents,
    });
    return { data: Uint8Array.from(archive).buffer };
  });
}

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
  await mkdir(dirname(analysisStatusPath), { recursive: true });
  await writeFile(analysisStatusPath, "true\n");
});

afterEach(async () => {
  await rm(temporaryDirectory, { recursive: true, force: true });
  vi.clearAllMocks();
});

describe("resolveMitigationTrigger", () => {
  it.each([
    ["Net", "azure-sdk-for-net"],
    ["Go", "azure-sdk-for-go"],
    ["Java", "azure-sdk-for-java"],
    ["Js", "azure-sdk-for-js"],
    ["Python", "azure-sdk-for-python"],
    ["Rust", "azure-sdk-for-rust"],
  ] as const)(
    "resolves %s mitigation inputs from a successful analysis result",
    async (sdkLanguage, sdkRepository) => {
      await writeAnalysisResult({ sdkLanguage });
      const github = createMockGithub();
      const context = createMockContext();
      const core = createMockCore();
      mockArtifactDownloads(github);
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
        analysisArtifactName,
        analysisStatusArtifactName,
        analysisStatusPath,
        mitigationStatusPath,
        publishedResultsPath: analysisResultPath,
        workflowRunId,
      });

      expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        run_id: workflowRunId,
        per_page: 100,
      });
      expect(github.rest.actions.downloadArtifact).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        artifact_id: 122,
        archive_format: "zip",
      });
      expect(github.rest.actions.downloadArtifact).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        artifact_id: 123,
        archive_format: "zip",
      });
      expect(core.setOutput).toHaveBeenCalledWith("should-run", "true");
      expect(core.setOutput).toHaveBeenCalledWith("pr-number", 42);
      expect(core.setOutput).toHaveBeenCalledWith("sdk-language", sdkLanguage);
      expect(core.setOutput).toHaveBeenCalledWith("sdk-repository", sdkRepository);
      expect(core.setOutput).toHaveBeenCalledWith("head-repository", "owner/repo");
      expect(core.setOutput).toHaveBeenCalledWith("head-sha", "a".repeat(40));
      expect(core.setOutput).toHaveBeenCalledWith("head-branch", "feature");
    },
  );

  it("skips mitigation when analysis failed", async () => {
    await writeAnalysisResult({
      status: "failure",
      errorMessage: "Analysis failed.",
    });
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    mockArtifactDownloads(github);

    await resolveMitigationTrigger({
      github,
      context,
      core,
      analysisArtifactName,
      analysisStatusArtifactName,
      analysisStatusPath,
      mitigationStatusPath,
      publishedResultsPath: analysisResultPath,
      workflowRunId,
    });

    expect(core.notice).toHaveBeenCalledWith("The SDK breaking-change analysis did not succeed.");
    expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("skips mitigation for a stale analysis head SHA", async () => {
    await writeAnalysisResult();
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    mockArtifactDownloads(github);
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: {
          ref: "feature",
          repo: { full_name: "owner/repo" },
          sha: "b".repeat(40),
        },
      },
    });

    await resolveMitigationTrigger({
      github,
      context,
      core,
      analysisArtifactName,
      analysisStatusArtifactName,
      analysisStatusPath,
      mitigationStatusPath,
      publishedResultsPath: analysisResultPath,
      workflowRunId,
    });
    expect(core.notice).toHaveBeenCalledWith(
      `Pull request head ${"b".repeat(40)} does not match analyzed head ${"a".repeat(40)}.`,
    );
    expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
  });

  it("skips mitigation when analysis was not requested", async () => {
    await writeFile(analysisStatusPath, "false\n");
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    mockArtifactDownloads(github);

    await resolveMitigationTrigger({
      github,
      context,
      core,
      analysisArtifactName,
      analysisStatusArtifactName,
      analysisStatusPath,
      mitigationStatusPath,
      publishedResultsPath: analysisResultPath,
      workflowRunId,
    });

    expect(core.notice).toHaveBeenCalledWith("The SDK breaking-change analysis was not requested.");
    expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
    expect(github.rest.actions.downloadArtifact).toHaveBeenCalledTimes(1);
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });
});
