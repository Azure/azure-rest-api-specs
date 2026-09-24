import { mkdirSync, writeFileSync } from "node:fs";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { parseCliArguments } from "../src/args.ts";
import { main } from "../src/index.ts";
import { createAzdskRunner } from "../src/release-plan.ts";
import { assertCleanSpecCheckout } from "../src/spec-target.ts";
import type { AzsdkRunner, CliArguments, OctokitLike } from "../src/types.ts";
import {
  createOctokit,
  getPrChangedFiles,
  getPullRequestLabels,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
} from "../src/typespec-project.ts";
import { API_VERSION, ok, plan, PR_URL, SPEC_PATH, SPEC_SHA, WORKSPACE } from "./test-helpers.ts";

vi.mock("../src/args.ts", () => ({ parseCliArguments: vi.fn() }));
vi.mock("node:fs", async (importOriginal) => ({
  ...(await importOriginal<typeof import("node:fs")>()),
  mkdirSync: vi.fn(),
  writeFileSync: vi.fn(),
}));
vi.mock("../src/release-plan.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/release-plan.ts")>()),
  createAzdskRunner: vi.fn(),
}));
vi.mock("../src/spec-target.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/spec-target.ts")>()),
  assertCleanSpecCheckout: vi.fn(),
}));
vi.mock("../src/typespec-project.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/typespec-project.ts")>()),
  createOctokit: vi.fn(),
  getPullRequestLabels: vi.fn(),
  getPrChangedFiles: vi.fn(),
  getTypeSpecProjectInfoFromPr: vi.fn(),
  getTypeSpecProjectInfoFromCommit: vi.fn(),
}));

describe("release-plan event orchestration", () => {
  let runner: ReturnType<typeof vi.fn<AzsdkRunner>>;
  let args: CliArguments;
  let octokit: OctokitLike;

  beforeEach(() => {
    vi.clearAllMocks();
    args = {
      prNumber: 123,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: WORKSPACE,
      outputFile: "release-plan.json",
      testReleasePlan: false,
    };
    runner = vi.fn<AzsdkRunner>(() => ok(plan()));
    octokit = {
      rest: {
        pulls: { get: vi.fn(), listFiles: vi.fn() },
        issues: { createComment: vi.fn() },
      },
    };
    vi.mocked(parseCliArguments).mockReturnValue(args);
    vi.mocked(createAzdskRunner).mockReturnValue(runner);
    vi.mocked(createOctokit).mockReturnValue(octokit);
    vi.mocked(getPullRequestLabels).mockResolvedValue(["new-api-version"]);
    vi.mocked(getPrChangedFiles).mockResolvedValue([{ filename: `${SPEC_PATH}/main.tsp` }]);
    vi.mocked(getTypeSpecProjectInfoFromPr).mockResolvedValue({
      tspProjectPath: SPEC_PATH,
      apiVersion: API_VERSION,
      isPreview: true,
      specCommitSha: SPEC_SHA,
    });
    vi.mocked(assertCleanSpecCheckout).mockReset();
    vi.spyOn(process, "exit").mockImplementation((code) => {
      throw new Error(`exit ${code}`);
    });
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("writes only the verified event target after rechecking the clean checkout", async () => {
    await main();
    expect(runner).toHaveBeenCalledOnce();
    expect(assertCleanSpecCheckout).toHaveBeenCalledWith(WORKSPACE, SPEC_SHA);
    expect(writeFileSync).toHaveBeenCalledOnce();
    expect(vi.mocked(assertCleanSpecCheckout).mock.invocationCallOrder.at(-1)).toBeLessThan(
      vi.mocked(writeFileSync).mock.invocationCallOrder[0],
    );
    const artifactText = vi.mocked(writeFileSync).mock.calls[0][1];
    if (typeof artifactText !== "string") {
      throw new Error("Expected a JSON artifact string");
    }
    const artifact = JSON.parse(artifactText) as {
      details: { apiVersion: string; specCommitSha: string };
    };
    expect(artifact.details.apiVersion).toBe(API_VERSION);
    expect(artifact.details.specCommitSha).toBe(SPEC_SHA);
    expect(octokit.rest.issues?.createComment).not.toHaveBeenCalled();
  });

  it.each([
    "Ambiguous API versions",
    "Automatic release planning requires merged spec PR",
    "workspace HEAD mismatch",
    "dirty checkout",
    "metadata compilation failed",
  ])("does not create a handoff or call azsdk on %s", async (message) => {
    vi.mocked(getTypeSpecProjectInfoFromPr).mockRejectedValueOnce(new Error(message));
    await expect(main()).rejects.toThrow("exit 1");
    expect(runner).not.toHaveBeenCalled();
    expect(writeFileSync).not.toHaveBeenCalled();
    expect(mkdirSync).not.toHaveBeenCalled();
    expect(octokit.rest.issues?.createComment).not.toHaveBeenCalled();
  });

  it("does not write a discovery artifact when checkout changes after plan selection", async () => {
    vi.mocked(assertCleanSpecCheckout)
      .mockImplementationOnce(() => {})
      .mockImplementationOnce(() => {
        throw new Error("HEAD changed");
      });
    await expect(main()).rejects.toThrow("exit 1");
    expect(writeFileSync).not.toHaveBeenCalled();
  });

  it("get-by-ID mode does not inspect metadata, GitHub, or the current HEAD", async () => {
    vi.mocked(parseCliArguments).mockReturnValue({ ...args, releasePlanId: "12345" });
    await main();
    expect(runner).toHaveBeenCalledExactlyOnceWith([
      "release-plan",
      "get",
      "--release-plan-id",
      "12345",
      "--output",
      "json",
    ]);
    expect(createOctokit).not.toHaveBeenCalled();
    expect(getTypeSpecProjectInfoFromPr).not.toHaveBeenCalled();
    expect(getTypeSpecProjectInfoFromCommit).not.toHaveBeenCalled();
    expect(assertCleanSpecCheckout).not.toHaveBeenCalled();
    expect(writeFileSync).toHaveBeenCalledOnce();
  });

  it("creates a private tracking artifact without sending public confirmation inputs", async () => {
    vi.mocked(parseCliArguments).mockReturnValue({ ...args, repo: "azure-rest-api-specs-pr" });
    const prUrl = PR_URL.replace("azure-rest-api-specs/", "azure-rest-api-specs-pr/");
    const privatePlan = plan({
      ApiReleaseType: 1,
      ActiveSpecPullRequest: prUrl,
      SpecCommitSHA: undefined,
    });
    runner
      .mockReturnValueOnce(ok(null))
      .mockReturnValueOnce(ok(null))
      .mockReturnValueOnce(ok(privatePlan))
      .mockReturnValueOnce(ok(privatePlan));

    await main();

    const createArgs = runner.mock.calls[2][0];
    expect(createArgs).toContain("Private Preview");
    for (const flag of ["--api-version", "--spec-commit-sha", "--confirm-target"]) {
      expect(createArgs).not.toContain(flag);
    }
    expect(getTypeSpecProjectInfoFromPr).toHaveBeenCalledOnce();
    expect(writeFileSync).toHaveBeenCalledWith(
      expect.any(String),
      expect.stringContaining('"apiVersion": "2026-01-01-preview"'),
      "utf8",
    );
  });

  it("does not create or write an artifact after a structured CLI lookup failure", async () => {
    runner.mockReturnValueOnce(
      ok({
        operation_status: "Failed",
        response_error: "Failed to get release plan details: permission denied",
      }),
    );
    await expect(main()).rejects.toThrow("exit 1");
    expect(runner).toHaveBeenCalledOnce();
    expect(writeFileSync).not.toHaveBeenCalled();
  });

  it("passes an explicitly supplied trigger SHA through PR-number resolution", async () => {
    vi.mocked(parseCliArguments).mockReturnValue({ ...args, commitSha: SPEC_SHA });
    await main();
    expect(getTypeSpecProjectInfoFromPr).toHaveBeenCalledWith(
      expect.objectContaining({ prNumber: 123, commitSha: SPEC_SHA }),
    );
  });

  it("uses the trigger commit's verified target in commit mode", async () => {
    vi.mocked(parseCliArguments).mockReturnValue({
      ...args,
      prNumber: undefined,
      commitSha: SPEC_SHA,
    });
    vi.mocked(getTypeSpecProjectInfoFromCommit).mockResolvedValueOnce({
      prNumber: 123,
      hasNewApiVersionLabel: true,
      projectInfo: {
        tspProjectPath: SPEC_PATH,
        apiVersion: API_VERSION,
        isPreview: true,
        specCommitSha: SPEC_SHA,
      },
    });
    await main();
    expect(getTypeSpecProjectInfoFromCommit).toHaveBeenCalledWith(
      expect.objectContaining({ commitSha: SPEC_SHA }),
    );
    expect(writeFileSync).toHaveBeenCalledOnce();
  });
});
