import path from "node:path";
import { beforeEach, describe, expect, it, vi } from "vitest";
const { mockGit } = vi.hoisted(() => ({
  mockGit: vi.fn<
    (
      command: string,
      args: string[],
      options: unknown,
    ) => {
      status: number;
      stdout: string;
      stderr: string;
    }
  >(),
}));
vi.mock("node:child_process", async (importOriginal) => ({
  ...(await importOriginal<typeof import("node:child_process")>()),
  spawnSync: mockGit,
}));
import {
  ensureReleasePlan,
  getApiReleaseType,
  getReleasePlanResultById,
  getSdkReleaseType,
} from "../src/release-plan.ts";
import type { AzsdkRunner, ReleasePlanDetails } from "../src/types.ts";
import { compareSpecCommits } from "../src/spec-target.ts";

beforeEach(() => mockGit.mockReset());

describe("release type helpers", () => {
  it("sets Private Preview for private specs repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs-pr")).toBe("Private Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs-pr")).toBe("Private Preview");
  });

  it("sets Public Preview or GA for public repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs")).toBe("Public Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs")).toBe("GA");
  });

  it("sets SDK release type", () => {
    expect(getSdkReleaseType(true)).toBe("beta");
    expect(getSdkReleaseType(false)).toBe("stable");
  });
});

describe("ensureReleasePlan", () => {
  function createRunner(
    outputs: Record<string, { code: number; out: string; err?: string }>,
  ): AzsdkRunner {
    return (args: string[]) => {
      const key = args.join(" ");
      const found = outputs[key];
      if (!found) {
        return { exitCode: 1, stdout: "", stderr: `Unexpected command: ${key}` };
      }

      return {
        exitCode: found.code,
        stdout: found.out,
        stderr: found.err || "",
      };
    };
  }

  const baseContext = {
    prUrl: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    tspProjectPath: "specification/foo/Contoso.Service",
    workspace: path.resolve("/repo/root"),
    specCommitSha: "a".repeat(40),
    apiReleaseType: "Public Preview" as const,
    sdkReleaseType: "beta" as const,
    targetMonth: "July 2026",
    apiVersion: "2026-06-01-preview",
    testReleasePlan: false,
  };

  const typespecPath = path.resolve(baseContext.workspace, baseContext.tspProjectPath);

  function buildPlan(id: number, details: ReleasePlanDetails = {}) {
    return {
      release_plan_link: `https://example.test/${id}`,
      release_plan_details: {
        ReleasePlanId: id,
        WorkItemId: id,
        APISpecProjectPath: baseContext.tspProjectPath,
        SpecAPIVersion: baseContext.apiVersion,
        ApiReleaseType: 2,
        SDKReleaseType: baseContext.sdkReleaseType,
        Status: "In Progress",
        SpecCommitSHA: baseContext.specCommitSha,
        ActiveSpecPullRequest: baseContext.prUrl,
        ...details,
      },
    };
  }

  it("returns existing release plan when found by PR", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        { code: 0, out: JSON.stringify(buildPlan(100)) },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_pr");
    expect(result.releasePlan).toEqual(buildPlan(100));

    // A squash/rebase merge replaces the same PR's saved source commit.
    const mergeSha = "b".repeat(40);
    const mergedPlan = buildPlan(100, { SpecCommitSHA: mergeSha });
    const mergeRunner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        { code: 0, out: JSON.stringify(buildPlan(100)) },
      [`release-plan update-spec-pr --workitem-id 100 --typespec-path ${typespecPath} --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --spec-commit-sha ${mergeSha} --output json`]:
        { code: 0, out: JSON.stringify({ status: "Success" }) },
      "release-plan get --workitem-id 100 --output json": {
        code: 0,
        out: JSON.stringify(mergedPlan),
      },
    });
    const merged = ensureReleasePlan({ ...baseContext, specCommitSha: mergeSha }, mergeRunner);
    expect(merged.outcome).toBe("existing_by_pr");
    expect(merged.releasePlan).toEqual(mergedPlan);
  });

  it("returns existing release plan when found by path with a different linked PR", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: JSON.stringify(
            buildPlan(101, {
              ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs/pull/122",
            }),
          ),
        },
      [`release-plan update-spec-pr --workitem-id 101 --typespec-path ${typespecPath} --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        { code: 0, out: JSON.stringify({ status: "Success" }) },
      "release-plan get --workitem-id 101 --output json": {
        code: 0,
        out: JSON.stringify(buildPlan(101)),
      },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_path");
    expect(result.releasePlan).toEqual(buildPlan(101));
  });

  it("creates release plan when no existing plan is found", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: "null",
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: JSON.stringify(buildPlan(999)),
        },
      "release-plan get --workitem-id 999 --output json": {
        code: 0,
        out: JSON.stringify(buildPlan(999)),
      },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual(buildPlan(999));

    // Create can reuse a legacy plan for this PR instead of creating another one.
    for (const apiVersion of [undefined, "", "   "]) {
      for (const specCommitSha of ["", baseContext.specCommitSha]) {
        const legacyPlan = buildPlan(999, {
          SpecAPIVersion: apiVersion,
          SpecCommitSHA: specCommitSha,
        });
        const calls: string[][] = [];
        const legacyRunner: AzsdkRunner = (args) => {
          calls.push(args);
          const response =
            args[1] === "create"
              ? legacyPlan
              : args[1] === "update-spec-pr"
                ? { status: "Success" }
                : args.includes("--workitem-id")
                  ? buildPlan(999)
                  : null;
          return { exitCode: 0, stdout: JSON.stringify(response), stderr: "" };
        };

        const reused = ensureReleasePlan(baseContext, legacyRunner);
        expect(reused.outcome).toBe("existing_by_pr");
        expect(reused.releasePlan).toEqual(buildPlan(999));
        expect(calls.map((args) => args[1])).toEqual(["get", "create", "update-spec-pr", "get"]);
        expect(calls[2]).toEqual([
          "release-plan",
          "update-spec-pr",
          "--workitem-id",
          "999",
          "--typespec-path",
          typespecPath,
          "--pull-request",
          baseContext.prUrl,
          "--spec-commit-sha",
          baseContext.specCommitSha,
          "--output",
          "json",
        ]);
      }
    }
  });

  it("passes test-release true when enabled", () => {
    const testReleaseContext = { ...baseContext, testReleasePlan: true };
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: "null",
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release true --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: JSON.stringify(buildPlan(1000)),
        },
      "release-plan get --workitem-id 1000 --output json": {
        code: 0,
        out: JSON.stringify(buildPlan(1000)),
      },
    });

    const result = ensureReleasePlan(testReleaseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual(buildPlan(1000));
  });

  describe("getReleasePlanResultById", () => {
    it("gets only the requested release plan", () => {
      const runner = vi.fn().mockReturnValue({
        exitCode: 0,
        stdout: JSON.stringify({ release_plan_details: { ReleasePlanId: "12345" } }),
        stderr: "",
      });

      const result = getReleasePlanResultById(" 12345 ", runner);

      expect(runner).toHaveBeenCalledOnce();
      expect(runner).toHaveBeenCalledWith([
        "release-plan",
        "get",
        "--release-plan-id",
        "12345",
        "--output",
        "json",
      ]);
      expect(result).toEqual({
        outcome: "existing_by_id",
        releasePlan: { release_plan_details: { ReleasePlanId: "12345" } },
        details: { releasePlanId: "12345" },
      });
    });
  });

  it("handles azsdk command failure on get", () => {
    const runner = vi.fn().mockReturnValue({
      exitCode: 1,
      stdout: "",
      stderr: "azsdk command not found",
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("azsdk command not found");
  });

  it("handles malformed JSON response from get", () => {
    const runner = vi.fn().mockReturnValue({
      exitCode: 0,
      stdout: "{ invalid json",
      stderr: "",
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow(
      "Invalid JSON from azsdk release-plan get.",
    );
  });

  it("handles malformed JSON response from create", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: "null",
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: "{ broken json",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow(
      "Invalid JSON from azsdk release-plan create.",
    );
  });

  it("handles create command failure", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: "null",
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 1,
          out: "",
          err: "Cannot create release plan",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("Cannot create release plan");
  });

  it("correctly handles december to january month wrap", () => {
    const decContext = { ...baseContext, targetMonth: "December 2025" };
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: "null",
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month December 2025 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: JSON.stringify(buildPlan(500)),
        },
      "release-plan get --workitem-id 500 --output json": {
        code: 0,
        out: JSON.stringify(buildPlan(500)),
      },
    });

    const result = ensureReleasePlan(decContext, runner);
    expect(result.outcome).toBe("created");
  });

  it("resolves relative tsp path for create command", () => {
    let capturedArgs: string[] = [];
    const runner = (args: string[]) => {
      if (args.includes("create")) {
        capturedArgs = args;
      }
      if (args.includes("get") && !args.includes("--workitem-id")) {
        return { exitCode: 0, stdout: "null", stderr: "" };
      }
      return { exitCode: 0, stdout: JSON.stringify(buildPlan(42)), stderr: "" };
    };

    ensureReleasePlan(baseContext, runner);
    const typespecPathArg = capturedArgs.indexOf("--typespec-path");
    expect(capturedArgs[typespecPathArg + 1]).toBe(typespecPath);
  });

  it("returns not_found in get-only mode when no release plan exists", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: "null",
        },
    });

    const result = ensureReleasePlan(baseContext, runner, false);
    expect(result.outcome).toBe("not_found");
    expect(result.releasePlan).toBeNull();
  });

  it.each(["Finished", "Abandoned", "Closed", "Duplicate"])(
    "does not update a %s plan returned by versioned lookup or concurrent create reuse",
    (status) => {
      for (const reusedByCreate of [false, true]) {
        const plan = buildPlan(100, {
          Status: status,
          ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs/pull/122",
        });
        const calls: string[][] = [];
        const runner: AzsdkRunner = (args) => {
          calls.push(args);
          return {
            exitCode: 0,
            stdout: JSON.stringify(reusedByCreate && calls.length === 1 ? null : plan),
            stderr: "",
          };
        };
        const result = ensureReleasePlan(baseContext, runner);
        expect(result.outcome).toBe("inactive_plan");
        expect(calls.map((args) => args[1])).toEqual(reusedByCreate ? ["get", "create"] : ["get"]);
        expect(result.releasePlan).toEqual(plan);
      }
    },
  );

  it("skips an older event without requesting a target update", () => {
    mockGit
      .mockReturnValueOnce({ status: 1, stdout: "", stderr: "" })
      .mockReturnValueOnce({ status: 0, stdout: "", stderr: "" });
    const runner = vi.fn(() => ({
      exitCode: 0,
      stdout: JSON.stringify(
        buildPlan(100, {
          SpecCommitSHA: "b".repeat(40),
          ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs/pull/124",
        }),
      ),
      stderr: "",
    }));
    expect(ensureReleasePlan(baseContext, runner).outcome).toBe("stale_event");
    expect(runner).toHaveBeenCalledOnce();
  });

  it("does not retry a concurrent writer failure or accept it as success", () => {
    const calls: string[][] = [];
    const runner: AzsdkRunner = (args) => {
      calls.push(args);
      return args[1] === "update-spec-pr"
        ? { exitCode: 1, stdout: JSON.stringify({ response_error: "target changed" }), stderr: "" }
        : {
            exitCode: 0,
            stdout: JSON.stringify(buildPlan(100, { SpecCommitSHA: "" })),
            stderr: "",
          };
    };
    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("target changed");
    expect(calls.map((args) => args[1])).toEqual(["get", "update-spec-pr"]);
  });
});

describe("spec commit ancestry", () => {
  const older = "a".repeat(40);
  const newer = "b".repeat(40);

  it("accepts the same commit without reading history", () => {
    expect(compareSpecCommits("/repo", older, older)).toBe("same");
    expect(mockGit).not.toHaveBeenCalled();
  });

  it.each([
    [0, "advance"],
    [1, "stale"],
  ] as const)(
    "classifies complete history with first ancestor result %s",
    (firstResult, expected) => {
      mockGit
        .mockReturnValueOnce({ status: firstResult, stdout: "", stderr: "" })
        .mockReturnValueOnce({ status: 0, stdout: "", stderr: "" });
      expect(compareSpecCommits("/repo", older, newer)).toBe(expected);
      expect(mockGit).toHaveBeenCalledWith(
        "git",
        ["--no-optional-locks", "-C", "/repo", "merge-base", "--is-ancestor", older, newer],
        expect.any(Object),
      );
    },
  );

  it.each([1, 128])("rejects divergent or unavailable history (%s)", (status) => {
    mockGit.mockReturnValue({ status, stdout: "", stderr: "missing history" });
    expect(() => compareSpecCommits("/repo", older, newer)).toThrow(/history|ancestry/);
  });
});
