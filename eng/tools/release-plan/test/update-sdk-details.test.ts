import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import type { AzsdkRunner, CommandResult } from "../src/types.ts";
import { runUpdateSdkDetails } from "../src/update-sdk-details.ts";
import { API_VERSION, cleanGit, OLD_SHA, plan, PR_URL, SPEC_SHA } from "./test-helpers.ts";

const WORKSPACE = path.resolve("/repo/root");
const SPEC_PATH = "specification/contoso/Contoso.Management";

function ok(stdout = ""): CommandResult {
  return { exitCode: 0, stdout, stderr: "" };
}

function buildArtifact(outcome: string, details: Record<string, unknown> = {}): string {
  return JSON.stringify({
    outcome,
    releasePlan: {
      operation_status: "Succeeded",
      release_plan_details: {
        ...plan().release_plan_details,
        ReleasePlanId: "12345",
        WorkItemId: "9001",
        APISpecProjectPath: SPEC_PATH,
        ...details,
      },
    },
  });
}

function buildPlan(details: Record<string, unknown>): string {
  return JSON.stringify({
    operation_status: "Succeeded",
    release_plan_details: {
      ...plan().release_plan_details,
      IsManagementPlane: true,
      SDKReleaseType: "beta",
      Status: "In progress",
      ...details,
    },
  });
}

describe("runUpdateSdkDetails", () => {
  const cliArgs = { artifactFile: "/tmp/release-plan.json", workspace: WORKSPACE };

  it("skips when release-plan outcome is not eligible", () => {
    const runner = vi.fn();

    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("not_found")),
      runner,
    });

    expect(runner).not.toHaveBeenCalled();
  });

  it("never updates metadata or the target of a plan retrieved directly by id", () => {
    const runner = vi.fn((args: string[]) => {
      if (args[0] === "release-plan" && args[1] === "get") {
        return ok(buildPlan({ Status: "Completed" }));
      }
      return ok();
    });

    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("existing_by_id")),
      runner,
    });

    expect(runner).not.toHaveBeenCalled();
  });

  it("skips update when release plan status is not In progress", () => {
    const runner = vi.fn((args: string[]) => {
      if (args[0] === "release-plan" && args[1] === "get") {
        return ok(buildPlan({ Status: "Completed" }));
      }
      return ok();
    });

    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("existing_by_path")),
      runner,
    });

    expect(runner).toHaveBeenCalledTimes(1);
    expect(runner).not.toHaveBeenCalledWith(expect.arrayContaining(["update"]));
  });

  it("updates SDK details when release plan is in progress", () => {
    const calls: string[][] = [];
    const runner = vi.fn((args: string[]) => {
      calls.push(args);
      if (args[0] === "release-plan" && args[1] === "get") {
        return ok(buildPlan({ Status: "In progress" }));
      }
      return ok(buildPlan({}));
    });

    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("created")),
      runner,
      git: cleanGit(),
    });

    expect(calls).toContainEqual([
      "release-plan",
      "update",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--workitem-id",
      "9001",
      "--sdk-type",
      "beta",
      "--pull-request",
      PR_URL,
      "--api-version",
      API_VERSION,
      "--spec-commit-sha",
      SPEC_SHA,
      "--confirm-target",
      "--expected-spec-commit-sha",
      SPEC_SHA,
      "--output",
      "json",
    ]);
  });

  it("keeps the artifact's exact observed pin rather than substituting the fresh representation", () => {
    const runner = vi.fn<AzsdkRunner>(() =>
      ok(buildPlan({ SpecCommitSHA: SPEC_SHA.toUpperCase() })),
    );
    runUpdateSdkDetails(cliArgs, {
      readArtifact: () => buildArtifact("created"),
      runner,
      git: cleanGit(),
    });
    const updateArgs = runner.mock.calls[1][0];
    expect(updateArgs[updateArgs.indexOf("--expected-spec-commit-sha") + 1]).toBe(SPEC_SHA);
  });

  it("refuses a fresh pin that changed since the artifact without updating", () => {
    const runner = vi.fn(() => ok(buildPlan({ SpecCommitSHA: OLD_SHA })));
    const git = cleanGit();
    expect(() =>
      runUpdateSdkDetails(cliArgs, {
        readArtifact: () => buildArtifact("created"),
        runner,
        git,
      }),
    ).toThrow(/changed since discovery/);
    expect(runner).toHaveBeenCalledOnce();
    expect(git).not.toHaveBeenCalled();
  });

  it("does not retry when the CLI rejects the artifact pin after the fresh lookup", () => {
    const runner = vi
      .fn<AzsdkRunner>()
      .mockReturnValueOnce(ok(buildPlan({})))
      .mockReturnValueOnce(
        ok(
          JSON.stringify({
            operation_status: "Failed",
            response_error: "Expected spec commit changed",
          }),
        ),
      );
    expect(() =>
      runUpdateSdkDetails(cliArgs, {
        readArtifact: () => buildArtifact("created"),
        runner,
        git: cleanGit(),
      }),
    ).toThrow(/Expected spec commit changed/);
    expect(runner).toHaveBeenCalledTimes(2);
    const updateArgs = runner.mock.calls[1][0];
    expect(updateArgs[updateArgs.indexOf("--expected-spec-commit-sha") + 1]).toBe(SPEC_SHA);
  });

  it("preserves the general private-preview update that can finish a merged tracking plan", () => {
    const prUrl = PR_URL.replace("azure-rest-api-specs/", "azure-rest-api-specs-pr/");
    const privateDetails = {
      ApiReleaseType: 1,
      ActiveSpecPullRequest: prUrl,
      SpecCommitSHA: undefined,
    };
    const runner = vi
      .fn<AzsdkRunner>()
      .mockReturnValueOnce(ok(buildPlan(privateDetails)))
      .mockReturnValueOnce(ok(buildPlan({ ...privateDetails, Status: "Finished" })))
      .mockReturnValueOnce(ok(buildPlan({ ...privateDetails, Status: "Finished" })));
    const git = cleanGit();
    runUpdateSdkDetails(cliArgs, {
      readArtifact: () => buildArtifact("existing_by_pr", privateDetails),
      runner,
      git,
    });
    expect(runner.mock.calls.map(([args]) => args[1])).toEqual(["get", "update", "get"]);
    expect(runner.mock.calls[1][0]).toEqual([
      "release-plan",
      "update",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--workitem-id",
      "9001",
      "--sdk-type",
      "beta",
      "--pull-request",
      prUrl,
      "--output",
      "json",
    ]);
    expect(git).not.toHaveBeenCalled();
  });

  it.each([
    { WorkItemId: "9002" },
    { ReleasePlanId: "54321" },
    { APISpecProjectPath: "specification/other/Other.Management" },
    { ActiveSpecPullRequest: PR_URL.replace("123", "456") },
  ])("does not update a private-preview plan with changed identity: %j", (details) => {
    const privateDetails = { ApiReleaseType: 1, SpecCommitSHA: undefined };
    const runner = vi.fn(() => ok(buildPlan({ ...privateDetails, ...details })));
    expect(() =>
      runUpdateSdkDetails(cliArgs, {
        readArtifact: () => buildArtifact("existing_by_pr", privateDetails),
        runner,
      }),
    ).toThrow(/changed since discovery/);
    expect(runner).toHaveBeenCalledOnce();
  });

  it("skips stale events without reading or updating the plan", () => {
    const runner = vi.fn();
    runUpdateSdkDetails(cliArgs, { readArtifact: () => buildArtifact("stale_event"), runner });
    expect(runner).not.toHaveBeenCalled();
  });

  it("requires the unchanged clean checkout before updating SDK details", () => {
    const runner = vi.fn(() => ok(buildPlan({})));
    expect(() =>
      runUpdateSdkDetails(cliArgs, {
        readArtifact: () => buildArtifact("created"),
        runner,
        git: cleanGit(OLD_SHA),
      }),
    ).toThrow(/HEAD/);
    expect(runner).toHaveBeenCalledOnce();
  });

  it.each([
    { requires_confirmation: true, ...plan() },
    { response_error: "Wrong commit" },
    { ...plan({ SpecCommitSHA: OLD_SHA }) },
  ])("rejects an unconfirmed or changed metadata update: %j", (response) => {
    const runner = vi
      .fn()
      .mockReturnValueOnce(ok(buildPlan({})))
      .mockReturnValueOnce(ok(JSON.stringify(response)));
    expect(() =>
      runUpdateSdkDetails(cliArgs, {
        readArtifact: () => buildArtifact("created"),
        runner,
        git: cleanGit(),
      }),
    ).toThrow();
    expect(runner).toHaveBeenCalledTimes(2);
  });
});
