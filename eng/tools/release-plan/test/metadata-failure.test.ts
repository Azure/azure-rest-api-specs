import { existsSync, mkdirSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import process from "node:process";
import { afterEach, beforeEach, describe, expect, it, vi, type MockInstance } from "vitest";

const { metadata, runner, getPullRequest, listFiles, listAssociations, getCommit } = vi.hoisted(
  () => ({
    metadata: vi.fn(),
    runner: vi.fn(),
    getPullRequest: vi.fn(),
    listFiles: vi.fn(),
    listAssociations: vi.fn(),
    getCommit: vi.fn(),
  }),
);

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: metadata,
}));

vi.mock("../src/typespec-project.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/typespec-project.ts")>()),
  createOctokit: () => ({
    rest: {
      pulls: { get: getPullRequest, listFiles },
      repos: { listPullRequestsAssociatedWithCommit: listAssociations, getCommit },
    },
  }),
}));

vi.mock("../src/release-plan.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/release-plan.ts")>()),
  createAzdskRunner: () => runner,
}));

import { main } from "../src/index.ts";
import { getTypeSpecProjectInfoFromCommit } from "../src/typespec-project.ts";

let workspace: string;
let outputFile: string;
let originalArgv: string[];
let exit: MockInstance<typeof process.exit>;

beforeEach(() => {
  vi.resetAllMocks();
  workspace = mkdtempSync(join(tmpdir(), "release-plan-metadata-failure-"));
  const project = join(workspace, "specification", "sample");
  mkdirSync(project, { recursive: true });
  writeFileSync(join(project, "tspconfig.yaml"), "emit: []\n");
  outputFile = join(workspace, "release-plan.json");
  originalArgv = process.argv;
  process.argv = [
    process.execPath,
    "create-release-plan",
    "--repo",
    "Azure/azure-rest-api-specs-pr",
    "--commit-sha",
    "abc123",
    "--workspace",
    workspace,
    "--output-file",
    outputFile,
  ];
  getPullRequest.mockResolvedValue({ data: { labels: [{ name: "new-api-version" }] } });
  const files = [{ filename: "specification/sample/tspconfig.yaml", status: "modified" }];
  listFiles.mockResolvedValue({ data: files });
  getCommit.mockResolvedValue({ data: { files } });
  exit = vi.spyOn(process, "exit").mockImplementation((code) => {
    throw new Error(`process.exit(${code})`);
  });
  vi.spyOn(console, "error").mockImplementation(() => {});
  vi.spyOn(console, "log").mockImplementation(() => {});
});

afterEach(() => {
  process.argv = originalArgv;
  vi.restoreAllMocks();
  rmSync(workspace, { recursive: true, force: true });
});

describe("metadata errors reach the release-plan CLI failure path", () => {
  it.each([
    { path: "merged PR", associated: true, failure: "compiler" },
    { path: "merged PR", associated: true, failure: "language configuration" },
    { path: "direct commit", associated: false, failure: "compiler" },
    { path: "direct commit", associated: false, failure: "language configuration" },
  ])("fails for a $failure error through the $path path", async ({ associated, failure }) => {
    listAssociations.mockResolvedValue({
      data: associated
        ? [{ number: 42, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "abc123" }]
        : [],
    });
    const message =
      failure === "compiler"
        ? "Failed to generate TypeSpec metadata: compiler failed"
        : "No valid language configurations found in TypeSpec metadata";
    if (failure === "compiler") {
      metadata.mockRejectedValue(new Error(message));
    } else {
      metadata.mockResolvedValue({ languages: {} });
    }

    await expect(main()).rejects.toThrow("process.exit(1)");

    expect(exit).toHaveBeenCalledExactlyOnceWith(1);
    expect(console.error).toHaveBeenCalledWith(`release-plan tool failed: ${message}`);
    expect(console.log).not.toHaveBeenCalledWith(
      "There are no TypeSpec changes in the PR or commit.",
    );
    expect(metadata).toHaveBeenCalledExactlyOnceWith(join(workspace, "specification", "sample"));
    expect(runner).not.toHaveBeenCalled();
    expect(existsSync(outputFile)).toBe(false);
  });

  it("keeps a genuine no-specification event as a non-error discovery result", async () => {
    listAssociations.mockResolvedValue({ data: [] });
    getCommit.mockResolvedValue({ data: { files: [{ filename: "eng/README.md" }] } });

    await expect(
      getTypeSpecProjectInfoFromCommit({
        commitSha: "abc123",
        owner: "Azure",
        repo: "azure-rest-api-specs-pr",
        workspace,
        octokit: {
          rest: {
            pulls: { get: getPullRequest, listFiles },
            repos: { listPullRequestsAssociatedWithCommit: listAssociations, getCommit },
          },
        },
      }),
    ).resolves.toEqual({ projectInfo: null, hasNewApiVersionLabel: false });

    expect(exit).not.toHaveBeenCalled();
    expect(metadata).not.toHaveBeenCalled();
    expect(runner).not.toHaveBeenCalled();
    expect(existsSync(outputFile)).toBe(false);
  });
});
