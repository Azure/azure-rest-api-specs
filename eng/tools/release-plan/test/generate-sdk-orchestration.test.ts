import path from "node:path";
import { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { describe, expect, it, vi } from "vitest";
import type { GenerateSdkDependencies } from "../src/generate-sdk.ts";
import { runGenerateSdk } from "../src/generate-sdk.ts";
import { ensureReleasePlan } from "../src/release-plan.ts";
import type { AzsdkRunner, CommandResult, OctokitLike } from "../src/types.ts";
import { API_VERSION, cleanGit, context, OLD_SHA, plan, PR_URL, SPEC_SHA } from "./test-helpers.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));

const WORKSPACE = path.resolve("/repo/root");
const SPEC_PATH = "specification/contoso/Contoso.Management";
const LANGUAGES = [".NET", "Java", "JavaScript", "Python", "Go"];

function ok(
  stdout = JSON.stringify({ status: "Success", operation_status: "Succeeded" }),
): CommandResult {
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
        ...plan().release_plan_details,
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
      ...plan().release_plan_details,
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
        "--api-version",
        API_VERSION,
        "--spec-commit-sha",
        SPEC_SHA,
        "--require-merged-spec",
        "true",
        "--output",
        "json",
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

  it("does not run release-plan update when SDKInfo is incomplete", async () => {
    const incompletePlan = buildPlan({
      SDKInfo: [{ Language: ".NET", PackageName: "", ReleaseExclusionStatus: "Not applicable" }],
    });
    const { deps, calls } = createHarness({
      getResponses: [incompletePlan],
    });

    await runGenerateSdk(cliArgs, deps);

    expect(calls.some((c) => c[0] === "release-plan" && c[1] === "update")).toBe(false);
    expect(calls.filter((c) => c[0] === "release-plan" && c[1] === "get")).toHaveLength(1);
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

  it("does not depend on release-plan update when SDKInfo is incomplete", async () => {
    const incompletePlan = buildPlan({
      SDKInfo: [{ Language: ".NET", PackageName: "", ReleaseExclusionStatus: "Not applicable" }],
    });
    const { deps, calls } = createHarness({
      runnerImpl: (args) => {
        if (args[0] === "release-plan" && args[1] === "get") {
          return ok(incompletePlan);
        }
        return ok();
      },
    });

    await expect(runGenerateSdk(cliArgs, deps)).resolves.toBeUndefined();
    expect(calls.some((c) => c[0] === "release-plan" && c[1] === "update")).toBe(false);
  });

  it("January preview plan keeps January and its old SHA when the live config defaults to June GA", async () => {
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue({
      emitterVersion: "0.3.0",
      generatedAt: "2026-06-01T00:00:00Z",
      typespec: { namespace: "Contoso", type: "management" },
      languages: {
        python: [{ emitterName: "python", apiVersion: "2026-06-01", sdkType: "stable" }],
      },
    });
    const { deps, calls } = createHarness({
      artifact: JSON.stringify({
        outcome: "existing_by_id",
        releasePlan: plan({ SpecCommitSHA: OLD_SHA }),
        details: { releasePlanId: "12345" },
      }),
      getResponses: [buildPlan({ SpecCommitSHA: OLD_SHA })],
    });

    await runGenerateSdk(cliArgs, deps);

    for (const language of LANGUAGES) {
      const args = generateCallFor(calls, language)!;
      expect(args[args.indexOf("--api-version") + 1]).toBe("2026-01-01-preview");
      expect(args[args.indexOf("--spec-commit-sha") + 1]).toBe(OLD_SHA);
      expect(args[args.indexOf("--release-type") + 1]).toBe("beta");
      expect(args).not.toContain("2026-06-01");
    }
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
    expect(calls.filter((args) => args[0] === "release-plan")).toHaveLength(1);
  });

  it("confirms a same-version merged follow-up, then regenerates only that new pin", async () => {
    const discoveryRunner = vi
      .fn<AzsdkRunner>()
      .mockReturnValueOnce(
        ok(
          JSON.stringify(
            plan({ SpecCommitSHA: OLD_SHA, ActiveSpecPullRequest: PR_URL.replace("123", "100") }),
          ),
        ),
      )
      .mockReturnValueOnce(ok())
      .mockReturnValueOnce(ok(buildPlan()));
    const discovered = ensureReleasePlan(context, discoveryRunner, true, cleanGit());
    const { deps, calls } = createHarness({ artifact: JSON.stringify(discovered) });

    await runGenerateSdk(cliArgs, deps);

    expect(discoveryRunner.mock.calls[1][0][1]).toBe("update-spec-pr");
    const updateArgs = discoveryRunner.mock.calls[1][0];
    expect(updateArgs[updateArgs.indexOf("--expected-spec-commit-sha") + 1]).toBe(OLD_SHA);
    for (const language of LANGUAGES) {
      const args = generateCallFor(calls, language)!;
      expect(args[args.indexOf("--api-version") + 1]).toBe(API_VERSION);
      expect(args[args.indexOf("--spec-commit-sha") + 1]).toBe(SPEC_SHA);
    }
  });

  it.each(["stale_event", "not_found"])(
    "never queues SDKs or fetches a plan for %s",
    async (outcome) => {
      const { deps, runner } = createHarness({
        artifact: JSON.stringify({ outcome, releasePlan: plan() }),
      });
      await runGenerateSdk(cliArgs, deps);
      expect(runner).not.toHaveBeenCalled();
    },
  );

  it("does not generate or backfill a private-preview plan without a pin", async () => {
    const privateDetails = {
      ApiReleaseType: 1,
      SpecCommitSHA: undefined,
      ActiveSpecPullRequest: PR_URL.replace("azure-rest-api-specs/", "azure-rest-api-specs-pr/"),
    };
    const { deps, calls } = createHarness({
      artifact: buildArtifact(privateDetails),
      getResponses: [buildPlan(privateDetails)],
    });
    await runGenerateSdk(cliArgs, deps);
    expect(calls.filter((args) => args[0] === "spec-workflow")).toHaveLength(0);
    expect(calls).toHaveLength(1);
  });

  it.each([
    { WorkItemId: "9002" },
    { ReleasePlanId: "54321" },
    { APISpecProjectPath: "specification/other/Other.Management" },
    { ActiveSpecPullRequest: PR_URL.replace("123", "456") },
  ])("rejects a wrong private-preview identity without generation: %j", async (details) => {
    const privateDetails = { ApiReleaseType: 1, SpecCommitSHA: undefined };
    const { deps, calls } = createHarness({
      artifact: buildArtifact(privateDetails),
      getResponses: [buildPlan({ ...privateDetails, ...details })],
    });
    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow(/changed since discovery/);
    expect(calls).toHaveLength(1);
  });

  it.each([
    { SpecAPIVersion: undefined },
    { SpecAPIVersion: "latest" },
    { SpecCommitSHA: undefined },
    { SpecCommitSHA: "HEAD" },
    { SpecCommitSHA: OLD_SHA },
    { SpecAPIVersion: "2026-06-01" },
    { APISpecProjectPath: "specification/other/Other.Management" },
    { WorkItemId: undefined },
    { WorkItemId: "9002" },
    { ReleasePlanId: "12346" },
    { ActiveSpecPullRequest: PR_URL.replace("123", "456") },
    { SDKReleaseType: "stable" },
    { ApiReleaseType: 3 },
  ])("rejects a missing or changed stored target without queueing: %j", async (details) => {
    const { deps, calls } = createHarness({ getResponses: [buildPlan(details)] });
    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow();
    expect(calls.filter((args) => args[0] === "spec-workflow")).toHaveLength(0);
  });

  it.each([{ SpecCommitSHA: undefined }, { WorkItemId: undefined }])(
    "does not infer missing artifact target fields: %j",
    async (details) => {
      const { deps, calls } = createHarness({ artifact: buildArtifact(details) });
      await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow();
      expect(calls.filter((args) => args[0] === "spec-workflow")).toHaveLength(0);
    },
  );

  it("rejects a mismatch between discovery selection and artifact plan details", async () => {
    const { deps, calls } = createHarness({
      artifact: JSON.stringify({
        outcome: "existing_by_pr",
        releasePlan: plan(),
        details: {
          prUrl: PR_URL,
          tspProjectPath: SPEC_PATH,
          apiVersion: "2026-06-01",
          specCommitSha: SPEC_SHA,
          apiReleaseType: "Public Preview",
          sdkReleaseType: "beta",
          targetReleaseMonth: "July 2026",
        },
      }),
    });
    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow(/explicit spec target/);
    expect(calls.filter((args) => args[0] === "spec-workflow")).toHaveLength(0);
  });

  it.each([
    { requires_confirmation: true, status: "Success" },
    { response_error: "Unmerged spec PR" },
    { response_errors: ["Stored pin changed"], status: "Failed" },
    { operation_status: "Failed" },
    {},
  ])("stops all remaining languages on a zero-exit unsafe CLI response: %j", async (response) => {
    const { deps, calls } = createHarness({
      runnerImpl: (args) =>
        args[0] === "release-plan" ? ok(buildPlan()) : ok(JSON.stringify(response)),
    });
    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow(/SDK generation failed/);
    expect(calls.filter((args) => args[0] === "spec-workflow")).toHaveLength(1);
  });

  it("uses the same expected pin and stops when the CLI detects a target race between languages", async () => {
    const { deps, calls } = createHarness({
      runnerImpl: (args) => {
        if (args[0] === "release-plan") return ok(buildPlan());
        if (args.includes("Java"))
          return ok(
            JSON.stringify({
              status: "Failed",
              response_error: "Expected spec commit no longer matches the release plan",
            }),
          );
        return ok();
      },
    });
    await expect(runGenerateSdk(cliArgs, deps)).rejects.toThrow(/Java/);
    const generated = calls.filter((args) => args[0] === "spec-workflow");
    expect(generated).toHaveLength(2);
    for (const args of generated)
      expect(args[args.indexOf("--spec-commit-sha") + 1]).toBe(SPEC_SHA);
  });
});
