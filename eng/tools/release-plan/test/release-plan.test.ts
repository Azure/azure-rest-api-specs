import { describe, expect, it, vi } from "vitest";
import { ensureReleasePlan, getApiReleaseType, getSdkReleaseType } from "../src/release-plan.ts";
import type { AzsdkRunner } from "../src/types.ts";

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
    apiReleaseType: "Public Preview" as const,
    sdkReleaseType: "beta" as const,
    targetMonth: "July 2026",
    apiVersion: "2026-06-01-preview",
    testReleasePlan: false,
  };

  it("returns existing release plan when found by PR", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 100, apiVersion: "2026-06-01-preview" }),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_pr");
    expect(result.releasePlan).toEqual({ id: 100, apiVersion: "2026-06-01-preview" });
  });

  it("returns existing release plan when found by path after PR lookup misses", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 101, apiVersion: "2026-06-01-preview" }),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_path");
    expect(result.releasePlan).toEqual({ id: 101, apiVersion: "2026-06-01-preview" });
  });

  it("creates release plan when no existing plan is found", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 999, release_plan_link: "https://example.test/999" }),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual({ id: 999, release_plan_link: "https://example.test/999" });
  });

  it("passes test-release true when enabled", () => {
    const testReleaseContext = { ...baseContext, testReleasePlan: true };
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release true --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 1000, release_plan_link: "https://example.test/1000" }),
        },
    });

    const result = ensureReleasePlan(testReleaseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual({
      id: 1000,
      release_plan_link: "https://example.test/1000",
    });
  });

  it("handles azsdk command failure on get-by-PR", () => {
    const runner = vi.fn().mockReturnValue({
      exitCode: 1,
      stdout: "",
      stderr: "azsdk command not found",
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("handles malformed JSON response from get-by-PR", () => {
    const runner = vi.fn().mockReturnValue({
      exitCode: 0,
      stdout: "{ invalid json",
      stderr: "",
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("handles malformed JSON response from create", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 0,
          out: "{ broken json",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("handles create command failure", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 1,
          out: "",
          err: "Cannot create release plan",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("correctly handles december to january month wrap", () => {
    const decContext = { ...baseContext, targetMonth: "December 2025" };
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --release-month December 2025 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 500 }),
        },
    });

    const result = ensureReleasePlan(decContext, runner);
    expect(result.outcome).toBe("created");
  });

  it("uses relative tsp path for create command", () => {
    let capturedArgs: string[] = [];
    const runner = (args: string[]) => {
      capturedArgs = args;
      if (args.includes("get")) {
        return { exitCode: 0, stdout: "null", stderr: "" };
      }
      return { exitCode: 0, stdout: JSON.stringify({ id: 42 }), stderr: "" };
    };

    ensureReleasePlan(baseContext, runner);
    const typespecPathArg = capturedArgs.indexOf("--typespec-path");
    expect(capturedArgs[typespecPathArg + 1]).toBe("specification/foo/Contoso.Service");
  });

  it("returns not_found in get-only mode when no release plan exists", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
    });

    const result = ensureReleasePlan(baseContext, runner, false);
    expect(result.outcome).toBe("not_found");
    expect(result.releasePlan).toBeNull();
  });
});
