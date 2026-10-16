import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";

import {
  resolveAnalysisTrigger,
  resolveChangedTypeSpecConfigPathsFromPullRequest,
  validateAnalysisSource,
} from "../../src/sdk-breaking-change/resolve-analysis-inputs.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const temporaryDirectories: string[] = [];

function createRepository(): string {
  const repositoryPath = join(import.meta.dirname, `repo-${crypto.randomUUID()}`);
  temporaryDirectories.push(repositoryPath);
  mkdirSync(join(repositoryPath, "specification", "service", "Widget.Service", "models"), {
    recursive: true,
  });
  mkdirSync(join(repositoryPath, "specification", "service", "Widget.Service", "new"), {
    recursive: true,
  });
  mkdirSync(join(repositoryPath, "specification", "other", "Other.Service"), {
    recursive: true,
  });
  writeFileSync(
    join(repositoryPath, "specification", "service", "Widget.Service", "tspconfig.yaml"),
    "emit: []\n",
  );
  writeFileSync(
    join(repositoryPath, "specification", "other", "Other.Service", "tspconfig.yaml"),
    "emit: []\n",
  );
  return repositoryPath;
}

function createStatusArtifactPath(): string {
  const directory = join(import.meta.dirname, `status-${crypto.randomUUID()}`);
  temporaryDirectories.push(directory);
  mkdirSync(directory, { recursive: true });
  return join(directory, "run");
}

afterEach(async () => {
  const { rm } = await import("node:fs/promises");
  await Promise.all(temporaryDirectories.splice(0).map((path) => rm(path, { recursive: true })));
  vi.clearAllMocks();
  vi.unstubAllEnvs();
});

describe("resolveAnalysisTrigger", () => {
  it.each([
    ["BreakingChange-Go-Sdk", "Go", "azure-sdk-for-go", "true"],
    ["BreakingChange-Java-Sdk", "Java", "azure-sdk-for-java", "true"],
    ["BreakingChange-JavaScript-Sdk", "JavaScript", "azure-sdk-for-js", "true"],
    ["BreakingChange-Python-Sdk", "Python", "azure-sdk-for-python", "true"],
    ["BreakingChange-Go-Sdk", "Go", "azure-sdk-for-go", "false"],
  ])(
    "resolves workflow-run inputs from %s artifacts (%s, %s, %s)",
    async (label, language, repository, labelValue) => {
      const github = createMockGithub();
      const context = createMockContext();
      const core = createMockCore();
      Object.assign(context, {
        eventName: "workflow_run",
        payload: { workflow_run: { id: 123, conclusion: "success" } },
      });
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: {
          artifacts: [
            { name: "issue-number=42" },
            { name: `head-sha=${"a".repeat(40)}` },
            { name: `label-${label}=${labelValue}` },
          ],
        },
      });
      github.rest.pulls.get.mockResolvedValue({
        data: {
          head: { repo: { full_name: "owner/repo" }, sha: "a".repeat(40) },
        },
      });

      const statusArtifactPath = createStatusArtifactPath();
      await resolveAnalysisTrigger({
        github,
        context,
        core,
        statusArtifactPath,
      });

      expect(core.setOutput).toHaveBeenCalledWith("pr-number", "42");
      expect(core.setOutput).toHaveBeenCalledWith("head-repository", "owner/repo");
      expect(core.setOutput).toHaveBeenCalledWith("head-sha", "a".repeat(40));
      expect(core.setOutput).toHaveBeenCalledWith("sdk-language", language);
      expect(core.setOutput).toHaveBeenCalledWith("sdk-repository", repository);
      expect(core.setOutput).toHaveBeenCalledWith("should-run", labelValue);
      expect(core.setOutput).not.toHaveBeenCalledWith("tsp-config-paths", expect.anything());
      expect(readFileSync(statusArtifactPath, "utf8")).toBe(`${labelValue}\n`);
    },
  );

  it.each([
    ["Go", "Go", "azure-sdk-for-go"],
    ["Java", "Java", "azure-sdk-for-java"],
    ["Js", "JavaScript", "azure-sdk-for-js"],
    ["Net", "DotNet", "azure-sdk-for-net"],
    ["Python", "Python", "azure-sdk-for-python"],
    ["Rust", "Rust", "azure-sdk-for-rust"],
  ])("normalizes %s workflow-dispatch inputs", async (input, language, repository) => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_dispatch",
      payload: { inputs: { pr_number: "42", sdk_language: input } },
    });
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { repo: { full_name: "owner/repo" }, sha: "a".repeat(40) },
      },
    });

    const statusArtifactPath = createStatusArtifactPath();
    await resolveAnalysisTrigger({ github, context, core, statusArtifactPath });

    expect(github.rest.pulls.get).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      pull_number: 42,
    });
    expect(core.setOutput).toHaveBeenCalledWith("pr-number", 42);
    expect(core.setOutput).toHaveBeenCalledWith("head-repository", "owner/repo");
    expect(core.setOutput).toHaveBeenCalledWith("head-sha", "a".repeat(40));
    expect(core.setOutput).toHaveBeenCalledWith("sdk-language", language);
    expect(core.setOutput).toHaveBeenCalledWith("sdk-repository", repository);
    expect(core.setOutput).toHaveBeenCalledWith("should-run", "true");
    expect(readFileSync(statusArtifactPath, "utf8")).toBe("true\n");
    expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
  });

  it.each(["", "Unknown"])("rejects invalid workflow-dispatch language %j", async (language) => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_dispatch",
      payload: { inputs: { pr_number: "42", sdk_language: language } },
    });

    const statusArtifactPath = createStatusArtifactPath();
    await expect(
      resolveAnalysisTrigger({ github, context, core, statusArtifactPath }),
    ).rejects.toThrow(`Invalid SDK language input: ${language}`);

    expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
    expect(readFileSync(statusArtifactPath, "utf8")).toBe("false\n");
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it.each(["0", "-1", "1.5", "not-a-number"])(
    "rejects invalid workflow-dispatch PR number %j",
    async (prNumber) => {
      const github = createMockGithub();
      const context = createMockContext();
      const core = createMockCore();
      Object.assign(context, {
        eventName: "workflow_dispatch",
        payload: { inputs: { pr_number: prNumber, sdk_language: "Go" } },
      });

      const statusArtifactPath = createStatusArtifactPath();
      await expect(
        resolveAnalysisTrigger({ github, context, core, statusArtifactPath }),
      ).rejects.toThrow(`Invalid pull request number: ${prNumber}`);

      expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
      expect(readFileSync(statusArtifactPath, "utf8")).toBe("false\n");
      expect(github.rest.pulls.get).not.toHaveBeenCalled();
    },
  );

  it("skips when no supported label artifact exists", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_run",
      payload: { workflow_run: { id: 123, conclusion: "success" } },
    });

    const statusArtifactPath = createStatusArtifactPath();
    await resolveAnalysisTrigger({
      github,
      context,
      core,
      statusArtifactPath,
    });

    expect(core.notice).toHaveBeenCalledWith(
      "No supported SDK breaking-change label artifact was published.",
    );
    expect(core.setOutput).toHaveBeenCalledWith("should-run", "false");
    expect(readFileSync(statusArtifactPath, "utf8")).toBe("false\n");
  });

  it("rejects multiple supported label artifacts", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_run",
      payload: { workflow_run: { id: 123, conclusion: "success" } },
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "label-BreakingChange-Go-Sdk=true" },
          { name: "label-BreakingChange-Java-Sdk=true" },
        ],
      },
    });

    const statusArtifactPath = createStatusArtifactPath();
    await expect(
      resolveAnalysisTrigger({
        github,
        context,
        core,
        statusArtifactPath,
      }),
    ).rejects.toThrow("Expected one SDK breaking-change label artifact");
    expect(readFileSync(statusArtifactPath, "utf8")).toBe("false\n");
  });

  it("rejects an incomplete label artifact handoff", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_run",
      payload: { workflow_run: { id: 123, conclusion: "success" } },
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "issue-number=42" }, { name: "label-BreakingChange-Go-Sdk=true" }],
      },
    });

    await expect(
      resolveAnalysisTrigger({
        github,
        context,
        core,
        statusArtifactPath: createStatusArtifactPath(),
      }),
    ).rejects.toThrow();
  });

  it("rejects a workflow-run handoff for a fork", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_run",
      payload: { workflow_run: { id: 123, conclusion: "success" } },
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "issue-number=42" },
          { name: `head-sha=${"a".repeat(40)}` },
          { name: "label-BreakingChange-Go-Sdk=true" },
        ],
      },
    });
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { repo: { full_name: "contributor/repo" }, sha: "a".repeat(40) },
      },
    });

    await expect(
      resolveAnalysisTrigger({
        github,
        context,
        core,
        statusArtifactPath: createStatusArtifactPath(),
      }),
    ).rejects.toThrow("does not run for fork");
  });

  it("rejects a stale workflow-run handoff SHA", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    Object.assign(context, {
      eventName: "workflow_run",
      payload: { workflow_run: { id: 123, conclusion: "success" } },
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "issue-number=42" },
          { name: `head-sha=${"a".repeat(40)}` },
          { name: "label-BreakingChange-Go-Sdk=true" },
        ],
      },
    });
    github.rest.pulls.get.mockResolvedValue({
      data: {
        head: { repo: { full_name: "owner/repo" }, sha: "b".repeat(40) },
      },
    });

    await expect(
      resolveAnalysisTrigger({
        github,
        context,
        core,
        statusArtifactPath: createStatusArtifactPath(),
      }),
    ).rejects.toThrow("Pull request head changed");
  });
});

describe("validateAnalysisSource", () => {
  it("accepts the expected repository and handoff SHA", () => {
    expect(() =>
      validateAnalysisSource({
        expectedRepository: "Azure/azure-rest-api-specs",
        actualRepository: "Azure/azure-rest-api-specs",
        expectedSha: "a".repeat(40),
        actualSha: "a".repeat(40),
      }),
    ).not.toThrow();
  });

  it("rejects a fork", () => {
    expect(() =>
      validateAnalysisSource({
        expectedRepository: "Azure/azure-rest-api-specs",
        actualRepository: "contributor/azure-rest-api-specs",
        actualSha: "a".repeat(40),
      }),
    ).toThrow("does not run for fork");
  });

  it("rejects a stale handoff SHA", () => {
    expect(() =>
      validateAnalysisSource({
        expectedRepository: "Azure/azure-rest-api-specs",
        actualRepository: "Azure/azure-rest-api-specs",
        expectedSha: "a".repeat(40),
        actualSha: "b".repeat(40),
      }),
    ).toThrow("Pull request head changed");
  });
});

describe("resolveChangedTypeSpecConfigPathsFromPullRequest", () => {
  it("reads all pull request files and sets the config path output", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    const localSpecRepoPath = createRepository();
    const listFiles = vi.fn().mockResolvedValue({
      data: [
        {
          filename: "specification/service/Widget.Service/new/main.tsp",
          previous_filename: "specification/service/Widget.Service/main.tsp",
        },
      ],
    });
    Object.assign(github.rest.pulls, { listFiles });
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    await expect(
      resolveChangedTypeSpecConfigPathsFromPullRequest({
        github,
        context,
        core,
        pullNumber: 42,
        localSpecRepoPath,
      }),
    ).resolves.toEqual(["specification/service/Widget.Service/tspconfig.yaml"]);
    expect(listFiles).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      pull_number: 42,
      per_page: 100,
    });
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
    expect(core.setOutput).toHaveBeenCalledWith(
      "tsp-config-paths",
      '["specification/service/Widget.Service/tspconfig.yaml"]',
    );
  });
});
