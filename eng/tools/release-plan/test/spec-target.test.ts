import { describe, expect, it, vi } from "vitest";
import {
  assertCleanSpecCheckout,
  compareSpecCommits,
  validateArtifactTarget,
  type GitRunner,
} from "../src/spec-target.ts";
import type { EnsureReleasePlanResult } from "../src/types.ts";
import {
  API_VERSION,
  cleanGit,
  OLD_SHA,
  plan,
  PR_URL,
  SPEC_PATH,
  SPEC_SHA,
  WORKSPACE,
} from "./test-helpers.ts";

describe("read-only spec checkout validation", () => {
  it("requires a full commit SHA rather than a branch or abbreviated commit", () => {
    const git = cleanGit();
    for (const sha of ["HEAD", "main", "abc123", "z".repeat(40), ""]) {
      expect(() => assertCleanSpecCheckout(WORKSPACE, sha, git)).toThrow(/40-character/);
    }
    expect(git).not.toHaveBeenCalled();
  });

  it("accepts only the selected clean checkout and issues no Git mutations", () => {
    const git = cleanGit();
    assertCleanSpecCheckout(WORKSPACE, SPEC_SHA.toUpperCase(), git);
    expect(git.mock.calls).toEqual([
      [WORKSPACE, ["rev-parse", "HEAD"]],
      [WORKSPACE, ["status", "--porcelain=v1", "--untracked-files=all"]],
    ]);
  });

  it.each([
    " M specification/foo/main.tsp",
    "M  specification/foo/main.tsp",
    "?? specification/foo/new.tsp",
  ])("rejects dirty, staged or untracked input: %s", (status) => {
    const git: GitRunner = (_workspace, args) => ({
      exitCode: 0,
      stdout: args[0] === "rev-parse" ? SPEC_SHA : status,
      stderr: "",
    });
    expect(() => assertCleanSpecCheckout(WORKSPACE, SPEC_SHA, git)).toThrow(/clean/);
  });

  it("does not interpret an unavailable Git status as a clean checkout", () => {
    const git = vi
      .fn<GitRunner>()
      .mockReturnValueOnce({ exitCode: 0, stdout: SPEC_SHA, stderr: "" })
      .mockReturnValueOnce({ exitCode: 128, stdout: "", stderr: "not a repository" });
    expect(() => assertCleanSpecCheckout(WORKSPACE, SPEC_SHA, git)).toThrow(/clean/);
  });
});

describe("spec commit ancestry", () => {
  it("classifies same, advancing and stale commits without changing history", () => {
    const git = cleanGit();
    expect(compareSpecCommits(WORKSPACE, SPEC_SHA, SPEC_SHA, git)).toBe("same");
    expect(git).not.toHaveBeenCalled();
    expect(compareSpecCommits(WORKSPACE, OLD_SHA, SPEC_SHA, git)).toBe("advance");
    expect(compareSpecCommits(WORKSPACE, SPEC_SHA, OLD_SHA, git)).toBe("stale");
    expect(git.mock.calls.every(([, args]) => args[0] === "merge-base")).toBe(true);
  });

  it.each([1, 128])("fails closed for divergent or unknown history (exit %s)", (exitCode) => {
    const git: GitRunner = () => ({ exitCode, stdout: "", stderr: "unknown history" });
    expect(() => compareSpecCommits(WORKSPACE, OLD_SHA, SPEC_SHA, git)).toThrow(/history|ancestry/);
  });
});

describe("private-preview artifact identity", () => {
  const prUrl = PR_URL.replace("azure-rest-api-specs/", "azure-rest-api-specs-pr/");
  const privatePlan = () =>
    plan({ ApiReleaseType: 1, ActiveSpecPullRequest: prUrl, SpecCommitSHA: undefined });
  const selection = {
    prUrl,
    tspProjectPath: SPEC_PATH,
    apiVersion: API_VERSION,
    specCommitSha: "",
    apiReleaseType: "Private Preview" as const,
    sdkReleaseType: "beta" as const,
    targetReleaseMonth: "July 2026",
  };
  const artifact = (): EnsureReleasePlanResult => ({
    outcome: "existing_by_pr",
    releasePlan: privatePlan(),
    details: selection,
  });

  it("checks the tracking target without requiring snapshot, selection or fresh commit pins", () => {
    const fresh = plan({ ...privatePlan().release_plan_details, SpecCommitSHA: "" });
    expect(validateArtifactTarget(artifact(), fresh, WORKSPACE)).toEqual(
      fresh.release_plan_details,
    );
  });

  it.each([
    { ReleasePlanId: "54321" },
    { WorkItemId: "9002" },
    { WorkItemId: undefined },
    { APISpecProjectPath: "specification/other/Other.Management" },
    { ActiveSpecPullRequest: prUrl.replace("123", "456") },
    { ActiveSpecPullRequest: undefined },
    { SpecAPIVersion: "2026-06-01" },
    { ApiReleaseType: 2 },
  ])("rejects a missing or changed private tracking identity: %j", (details) => {
    const fresh = plan({ ...privatePlan().release_plan_details, ...details });
    expect(() => validateArtifactTarget(artifact(), fresh, WORKSPACE)).toThrow();
  });

  it("rejects an explicit private selection that disagrees with the linked PR", () => {
    const mismatched = { ...artifact(), details: { ...selection, prUrl: PR_URL } };
    expect(() => validateArtifactTarget(mismatched, privatePlan(), WORKSPACE)).toThrow(
      /explicit spec target/,
    );
  });
});
