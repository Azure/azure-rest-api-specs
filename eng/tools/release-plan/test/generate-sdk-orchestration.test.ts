import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import type { GenerateSdkDependencies } from "../src/generate-sdk.ts";
import { runGenerateSdk } from "../src/generate-sdk.ts";
import type { CommandResult, OctokitLike } from "../src/types.ts";

const WORKSPACE = path.resolve("/repo/root");
const SPEC_PATH = "specification/contoso/Contoso.Management";
const LANGUAGES = [".NET", "Java", "JavaScript", "Python", "Go"];

function ok(stdout = ""): CommandResult {
  return { exitCode: 0, stdout, stderr: "" };
}

function fail(stderr = "boom"): CommandResult {
  return { exitCode: 1, stdout: "", stderr };
}

/**
 * Builds a release plan artifact (as written by the create-release-plan tool).
 */
function buildArtifact(overrides: Record<string, unknown> = {}): string {
  return JSON.stringify({
    outcome: "existing_by_path",
    releasePlan: {
      release_plan_details: {
        ReleasePlanId: "12345",
        WorkItemId: "9001",
        APISpecProjectPath: SPEC_PATH,
        ...overrides,
      },
    },
  });
}

/**
 * Builds the release plan returned by `azsdk release-plan get --release-plan-id`.
 */
function buildPlan(details: Record<string, unknown> = {}): string {
  return JSON.stringify({
    release_plan_details: {
      IsManagementPlane: true,
      SDKReleaseType: "beta",
      SDKInfo: LANGUAGES.map((language) => ({
        Language: language,
        PackageName: `azure-mgmt-${language.toLowerCase()}`,
        ReleaseStatus: "",
        SdkPullRequestUrl: "",
        ReleaseExclusionStatus: "Not applicable",
      })),
      ...details,
    },
  });
}

function createOctokitMock(): OctokitLike {
  return {
    rest: {
      pulls: {
        get: vi.fn(),
        listFiles: vi.fn(),
      },
    },
  };
}

interface HarnessOptions {
  artifact?: string;
  getResponses?: string[];
  runnerImpl?: (args: string[]) => CommandResult;
}

function createHarness(options: HarnessOptions = {}) {
  const calls: string[][] = [];
  const getResponses = options.getResponses ?? [buildPlan()];
  let getIndex = 0;

  const runner = vi.fn((args: string[]): CommandResult => {
    calls.push(args);
    if (options.runnerImpl) {
      return options.runnerImpl(args);
    }
    if (args[0] === "release-plan" && args[1] === "get") {
      const response = getResponses[Math.min(getIndex, getResponses.length - 1)];
      getIndex += 1;
      return ok(response);
    }
    return ok();
  });

  const deps: GenerateSdkDependencies = {
    readArtifact: vi.fn(() => options.artifact ?? buildArtifact()),
    runner,
    octokit: createOctokitMock(),
  };

  return { deps, runner, calls };
}

const cliArgs = { artifactFile: "/tmp/release-plan.json", workspace: WORKSPACE };

function generateCallFor(calls: string[][], language: string): string[] | undefined {
  return calls.find((c) => c[0] === "spec-workflow" && c.includes(language));
}

describe("runGenerateSdk orchestration", () => {
  it("generates SDKs for every language with the exact azsdk command contract", async () => {
    const { deps, calls } = createHarness();

    await runGenerateSdk(cliArgs, deps);

    // Fetches the authoritative release plan by id.
    expect(calls).toContainEqual([
      "release-plan",
      "get",
      "--release-plan-id",
      "12345",
      "--output",
      "json",
    ]);

    // No update needed because SDKInfo is complete.
    expect(calls.some((c) => c[0] === "release-plan" && c[1] === "update")).toBe(false);

    // Every language is generated with the resolved (absolute) typespec path.
    for (const language of LANGUAGES) {
      expect(calls).toContainEqual([
        "spec-workflow",
        "generate-sdk",
        "--typespec-project",
        path.resolve(WORKSPACE, SPEC_PATH),
        "--release-type",
        "beta",
        "--language",
        language,
        "--workitem-id",
        "9001",
      ]);
    }
  });

  it("skips generation entirely when the plan is not management plane", async () => {
    const { deps, calls } = createHarness({
      getResponses: [buildPlan({ IsManagementPlane: false })],
    });

    await runGenerateSdk(cliArgs, deps);

    expect(calls.some((c) => c[0] === "spec-workflow")).toBe(false);
    expect(calls.some((c) => c[0] === "release-plan" && c[1] === "update")).toBe(false);
  });

  it("does nothing and never calls azsdk when the release plan id is absent", async () => {
    const { deps, runner } = createHarness({
      artifact: JSON.stringify({ outcome: "not_found", releasePlan: null }),
    });

    await runGenerateSdk(cliArgs, deps);

    expect(runner).not.toHaveBeenCalled();
  });

  it("runs release-plan update with the exact contract when SDKInfo is incomplete", async () => {
    const incompletePlan = buildPlan({
      SDKInfo: [{ Language: ".NET", PackageName: "", ReleaseExclusionStatus: "Not applicable" }],
    });
    const { deps, calls } = createHarness({
      getResponses: [incompletePlan, buildPlan()],
    });

    await runGenerateSdk(cliArgs, deps);

    expect(calls).toContainEqual([
      "release-plan",
      "update",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--workitem-id",
      "9001",
      "--sdk-type",
      "beta",
    ]);
    // Re-fetches the plan after the update (two get calls).
    expect(calls.filter((c) => c[0] === "release-plan" && c[1] === "get")).toHaveLength(2);
  });

  it("does not generate an excluded language but still generates the others", async () => {
    const planWithExclusion = buildPlan({
      SDKInfo: LANGUAGES.map((language) => ({
        Language: language,
        PackageName: `azure-mgmt-${language.toLowerCase()}`,
        ReleaseStatus: "",
        SdkPullRequestUrl: "",
        ReleaseExclusionStatus: language === "Go" ? "MissingEmitterConfig" : "Not applicable",
      })),
    });
    const { deps, calls } = createHarness({ getResponses: [planWithExclusion] });

    await runGenerateSdk(cliArgs, deps);

    expect(generateCallFor(calls, "Go")).toBeUndefined();
    for (const language of [".NET", "Java", "JavaScript", "Python"]) {
      expect(generateCallFor(calls, language)).toBeDefined();
    }
  });

  it("throws when a language SDK generation fails", async () => {
    const { deps } = createHarness({
      runnerImpl: (args) => {
        if (args[0] === "release-plan" && args[1] === "get") {
          return ok(buildPlan());
        }
        if (args[0] === "spec-workflow" && args.includes("Java")) {
          return fail("java generation failed");
        }
        return ok();
      },
    });

    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow(/SDK generation failed.*Java/);
  });

  it("throws when the release-plan update fails", async () => {
    const incompletePlan = buildPlan({
      SDKInfo: [{ Language: ".NET", PackageName: "", ReleaseExclusionStatus: "Not applicable" }],
    });
    const { deps } = createHarness({
      runnerImpl: (args) => {
        if (args[0] === "release-plan" && args[1] === "get") {
          return ok(incompletePlan);
        }
        if (args[0] === "release-plan" && args[1] === "update") {
          return fail("update failed");
        }
        return ok();
      },
    });

    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow(/release-plan update failed/);
  });
});
