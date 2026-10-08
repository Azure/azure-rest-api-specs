import { describe, expect, it, vi } from "vitest";
import {
  ensureReleasePlan,
  getApiReleaseType,
  getReleasePlanResultById,
  getSdkReleaseType,
} from "../src/release-plan.ts";
import type { AzsdkRunner, ReleasePlanDetails } from "../src/types.ts";

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
    specCommitSha: "a".repeat(40),
    apiReleaseType: "Public Preview" as const,
    sdkReleaseType: "beta" as const,
    targetMonth: "July 2026",
    apiVersion: "2026-06-01-preview",
    testReleasePlan: false,
  };

  const typespecPath = baseContext.tspProjectPath;

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
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: JSON.stringify(buildPlan(100)) },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_pr");
    expect(result.releasePlan).toEqual(buildPlan(100));
  });

  it("returns existing release plan when found by path with a different linked PR", () => {
    const runner = createRunner({
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: "null" },
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 0,
          out: JSON.stringify(
            buildPlan(101, {
              ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs/pull/122",
            }),
          ),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_path");
    expect(result.releasePlan).toEqual(
      buildPlan(101, {
        ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs/pull/122",
      }),
    );
    expect(result.details).toMatchObject({ specCommitSha: baseContext.specCommitSha });
  });

  it("creates release plan when no existing plan is found", () => {
    const runner = createRunner({
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: "null" },
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
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual(buildPlan(999));
  });

  it("passes test-release true when enabled", () => {
    const testReleaseContext = { ...baseContext, testReleasePlan: true };
    const runner = createRunner({
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: "null" },
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

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("Failed to parse JSON");
  });

  it("handles malformed JSON response from create", () => {
    const runner = createRunner({
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: "null" },
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

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("Failed to parse JSON");
  });

  it("handles create command failure", () => {
    const runner = createRunner({
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: "null" },
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
      [`release-plan get --pull-request ${baseContext.prUrl} --api-release-type Public Preview --output json`]:
        { code: 0, out: "null" },
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
    });

    const result = ensureReleasePlan(decContext, runner);
    expect(result.outcome).toBe("created");
  });

  it("uses relative tsp path for create command", () => {
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
    const runner = vi.fn<AzsdkRunner>(() => ({ exitCode: 0, stdout: "null", stderr: "" }));
    const result = ensureReleasePlan(baseContext, runner, false);

    expect(result.outcome).toBe("not_found");
    expect(result.releasePlan).toBeNull();
    expect(runner).toHaveBeenCalledTimes(2);
  });

  it.each(["Public Preview", "GA", "Private Preview"] as const)(
    "filters PR lookup by %s and does not update during discovery",
    (apiReleaseType) => {
      const runner = vi.fn<AzsdkRunner>(() => ({
        exitCode: 0,
        stdout: JSON.stringify(buildPlan(100)),
        stderr: "",
      }));

      expect(ensureReleasePlan({ ...baseContext, apiReleaseType }, runner).outcome).toBe(
        "existing_by_pr",
      );
      expect(runner).toHaveBeenCalledOnce();
      expect(runner).toHaveBeenCalledWith([
        "release-plan",
        "get",
        "--pull-request",
        baseContext.prUrl,
        "--api-release-type",
        apiReleaseType,
        "--output",
        "json",
      ]);
    },
  );

  it("creates private-preview tracking plans without a public commit pin", () => {
    const runner = vi.fn<AzsdkRunner>((args) => ({
      exitCode: 0,
      stdout: JSON.stringify(args[1] === "get" ? null : buildPlan(999)),
      stderr: "",
    }));
    expect(
      ensureReleasePlan(
        { ...baseContext, apiReleaseType: "Private Preview", apiVersion: "" },
        runner,
      ).outcome,
    ).toBe("created");
    expect(runner.mock.calls.at(-1)![0]).not.toContain("--spec-commit-sha");
  });

  it("returns existing plans with an empty API version", () => {
    const plan = buildPlan(100, { SpecAPIVersion: "" });
    const runner = vi.fn<AzsdkRunner>((args) => ({
      exitCode: 0,
      stdout: JSON.stringify(args.includes("--pull-request") ? null : plan),
      stderr: "",
    }));
    expect(ensureReleasePlan({ ...baseContext, apiVersion: "" }, runner).releasePlan).toEqual(plan);
    expect(runner).toHaveBeenLastCalledWith(expect.arrayContaining(["--api-version", ""]));
  });
});
