import { describe, expect, it, vi } from "vitest";
import { checkIfSdkNeedsToBeGenerated } from "../src/generate-sdk.ts";
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

  const noMatchJson = JSON.stringify({
    outcome: "not_found",
    response_error: "Failed to get release plan details.",
    operation_status: "Failed",
  });

  function buildPlan(
    id: number,
    details: ReleasePlanDetails = {},
    outcome: "existing" | "created" = "existing",
  ) {
    return {
      outcome,
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

  it.each(["In Progress", "Finished", " in progress ", "FINISHED"])(
    "reuses a plan for the same API version in %s status",
    (status) => {
      const plan = buildPlan(100, { Status: status });
      const runner = vi.fn<AzsdkRunner>(() => ({
        exitCode: 0,
        stdout: JSON.stringify(plan),
        stderr: "",
      }));

      const result = ensureReleasePlan(baseContext, runner);

      expect(result.outcome).toBe("existing_by_path");
      expect(result.releasePlan).toEqual(plan);
      expect(runner).toHaveBeenCalledOnce();
      expect(runner).toHaveBeenCalledWith([
        "release-plan",
        "get",
        "--typespec-path",
        typespecPath,
        "--api-version",
        baseContext.apiVersion,
        "--api-release-type",
        baseContext.apiReleaseType,
        "--output",
        "json",
      ]);
    },
  );

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
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 1,
          out: noMatchJson,
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --expected-api-version ${baseContext.apiVersion} --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: JSON.stringify(buildPlan(999, {}, "created")),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual(buildPlan(999, {}, "created"));
  });

  it("passes test-release true when enabled", () => {
    const testReleaseContext = { ...baseContext, testReleasePlan: true };
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 1,
          out: noMatchJson,
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release true --expected-api-version ${baseContext.apiVersion} --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: JSON.stringify(buildPlan(1000, {}, "created")),
        },
    });

    const result = ensureReleasePlan(testReleaseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual(buildPlan(1000, {}, "created"));
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
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 1,
          out: noMatchJson,
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --expected-api-version ${baseContext.apiVersion} --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: "{ broken json",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("Failed to parse JSON");
  });

  it("handles create command failure", () => {
    const runner = createRunner({
      [`release-plan get --typespec-path ${typespecPath} --api-version 2026-06-01-preview --api-release-type Public Preview --output json`]:
        {
          code: 1,
          out: noMatchJson,
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --expected-api-version ${baseContext.apiVersion} --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
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
          code: 1,
          out: noMatchJson,
        },
      [`release-plan create --typespec-path ${typespecPath} --api-release-type Public Preview --release-month December 2025 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --test-release false --expected-api-version ${baseContext.apiVersion} --spec-commit-sha ${baseContext.specCommitSha} --output json`]:
        {
          code: 0,
          out: JSON.stringify(buildPlan(500, {}, "created")),
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
        return { exitCode: 1, stdout: noMatchJson, stderr: "" };
      }
      return { exitCode: 0, stdout: JSON.stringify(buildPlan(42, {}, "created")), stderr: "" };
    };

    ensureReleasePlan(baseContext, runner);
    const typespecPathArg = capturedArgs.indexOf("--typespec-path");
    expect(capturedArgs[typespecPathArg + 1]).toBe(typespecPath);
  });

  it.each([
    { Status: "Closed" },
    { Status: "Abandoned" },
    { Status: "Duplicate" },
    { Status: "Completed" },
    { Status: "In Progress", SpecAPIVersion: "2025-01-01-preview" },
    { Status: "Finished", SpecAPIVersion: "2025-01-01-preview" },
  ])("rejects a lookup result that contradicts the requested identity: %j", (details) => {
    const runner = vi.fn<AzsdkRunner>(() => ({
      exitCode: 0,
      stdout: JSON.stringify(buildPlan(100, details)),
      stderr: "",
    }));

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow(
      /does not match|not In Progress or Finished/,
    );
    expect(runner).toHaveBeenCalledOnce();
  });

  it.each([{ Status: undefined }, { SpecAPIVersion: undefined }])(
    "fails instead of creating duplicates when plan identity is missing: %j",
    (details) => {
      const runner = vi.fn<AzsdkRunner>(() => ({
        exitCode: 0,
        stdout: JSON.stringify(buildPlan(100, details)),
        stderr: "",
      }));

      expect(() => ensureReleasePlan(baseContext, runner)).toThrow(
        "missing its API version, status, or project path",
      );
      expect(runner).toHaveBeenCalledOnce();
    },
  );

  it("creates a plan after the CLI's explicit no-match response", () => {
    const runner = vi.fn<AzsdkRunner>((args) =>
      args[1] === "get"
        ? {
            exitCode: 1,
            stdout: JSON.stringify({
              outcome: "not_found",
              response_error: "Failed to get release plan details.",
              operation_status: "Failed",
            }),
            stderr: "",
          }
        : { exitCode: 0, stdout: JSON.stringify(buildPlan(999, {}, "created")), stderr: "" },
    );

    expect(ensureReleasePlan(baseContext, runner).outcome).toBe("created");
    expect(runner).toHaveBeenCalledTimes(2);
  });

  it("reports when creation requires a PR instead of silently returning no plan", () => {
    const runner = vi.fn<AzsdkRunner>(() => ({ exitCode: 1, stdout: noMatchJson, stderr: "" }));

    expect(() => ensureReleasePlan({ ...baseContext, prUrl: undefined }, runner)).toThrow(
      "No pull request URL could be resolved",
    );
    expect(runner).toHaveBeenCalledOnce();
  });

  it.each([
    { exitCode: 1, stdout: "", stderr: "Access denied", error: "Access denied" },
    {
      exitCode: 1,
      stdout: JSON.stringify({
        response_error: "Failed to get release plan details: Access denied",
      }),
      stderr: "",
      error: "Access denied",
    },
    { exitCode: 0, stdout: "{ invalid JSON", stderr: "", error: "Failed to parse JSON" },
    { exitCode: 0, stdout: "[]", stderr: "", error: "Expected JSON object" },
    { exitCode: 0, stdout: '"unexpected"', stderr: "", error: "Expected JSON object" },
  ])("does not hide a failed lookup or create a plan: $error ($stdout)", (response) => {
    const runner = vi.fn<AzsdkRunner>(() => response);

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow(response.error);
    expect(runner).toHaveBeenCalledOnce();
  });

  it.each(["Public Preview", "GA", "Private Preview"] as const)(
    "filters project and API-version lookup by %s without updating during discovery",
    (apiReleaseType) => {
      const runner = vi.fn<AzsdkRunner>(() => ({
        exitCode: 0,
        stdout: JSON.stringify(buildPlan(100)),
        stderr: "",
      }));

      expect(ensureReleasePlan({ ...baseContext, apiReleaseType }, runner).outcome).toBe(
        "existing_by_path",
      );
      expect(runner).toHaveBeenCalledOnce();
      expect(runner).toHaveBeenCalledWith([
        "release-plan",
        "get",
        "--typespec-path",
        typespecPath,
        "--api-version",
        baseContext.apiVersion,
        "--api-release-type",
        apiReleaseType,
        "--output",
        "json",
      ]);
    },
  );

  it("creates private-preview tracking plans without a public commit pin", () => {
    const runner = vi.fn<AzsdkRunner>((args) => ({
      exitCode: args[1] === "get" ? 1 : 0,
      stdout: args[1] === "get" ? noMatchJson : JSON.stringify(buildPlan(999, {}, "created")),
      stderr: "",
    }));
    expect(
      ensureReleasePlan({ ...baseContext, apiReleaseType: "Private Preview" }, runner).outcome,
    ).toBe("created");
    expect(runner.mock.calls.at(-1)![0]).not.toContain("--spec-commit-sha");
  });

  it.each(["", " ", "all", "multiple-versions", "ALL"])(
    "requires manual selection without CLI reads or writes for version '%s'",
    (apiVersion) => {
      const runner = vi.fn<AzsdkRunner>();

      expect(ensureReleasePlan({ ...baseContext, apiVersion }, runner)).toMatchObject({
        outcome: "manual_required",
        releasePlan: null,
      });
      expect(runner).not.toHaveBeenCalled();
    },
  );

  it("classifies CLI reuse as existing and does not regenerate a released SDK", async () => {
    const plan = buildPlan(100);
    const runner = vi
      .fn<AzsdkRunner>()
      .mockReturnValueOnce({ exitCode: 1, stdout: noMatchJson, stderr: "" })
      .mockReturnValueOnce({ exitCode: 0, stdout: JSON.stringify(plan), stderr: "" });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result).toMatchObject({
      outcome: "existing_by_path",
      releasePlan: plan,
    });
    const get = vi.fn();
    expect(
      await checkIfSdkNeedsToBeGenerated({
        language: ".NET",
        outcomeNormalized: result.outcome,
        sdkInfoItems: [{ Language: ".NET", ReleaseStatus: "Released" }],
        octokit: { rest: { pulls: { get, listFiles: vi.fn() } } },
      }),
    ).toBe(false);
    expect(get).not.toHaveBeenCalled();
  });

  it.each(["existing", "created"] as const)(
    "rejects an older plan returned by create with outcome %s",
    (outcome) => {
      const runner = vi
        .fn<AzsdkRunner>()
        .mockReturnValueOnce({ exitCode: 1, stdout: noMatchJson, stderr: "" })
        .mockReturnValueOnce({
          exitCode: 0,
          stdout: JSON.stringify(buildPlan(100, { SpecAPIVersion: "2025-01-01" }, outcome)),
          stderr: "",
        });

      expect(() => ensureReleasePlan(baseContext, runner)).toThrow("does not match");
    },
  );

  it("stops before creation when an older CLI omits the lookup outcome", () => {
    const { outcome: omitted, ...legacyPlan } = buildPlan(100);
    expect(omitted).toBe("existing");
    const runner = vi.fn<AzsdkRunner>(() => ({
      exitCode: 0,
      stdout: JSON.stringify(legacyPlan),
      stderr: "",
    }));

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("Update the azsdk CLI");
    expect(runner).toHaveBeenCalledOnce();
  });

  it("rejects contradictory no-match responses instead of hiding lookup errors", () => {
    const runner = vi.fn<AzsdkRunner>(() => ({
      exitCode: 1,
      stdout: JSON.stringify({ outcome: "not_found", response_error: "Access denied" }),
      stderr: "",
    }));

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow("Invalid no-match response");
    expect(runner).toHaveBeenCalledOnce();
  });
});
