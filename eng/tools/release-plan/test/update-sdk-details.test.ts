import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import type { CommandResult } from "../src/types.ts";
import { runUpdateSdkDetails } from "../src/update-sdk-details.ts";

const WORKSPACE = path.resolve("/repo/root");
const SPEC_PATH = "specification/contoso/Contoso.Management";
const PLAN_TARGET = {
  ReleasePlanId: "12345",
  WorkItemId: "9001",
  APISpecProjectPath: SPEC_PATH,
  SpecAPIVersion: "2026-06-01-preview",
  SpecCommitSHA: "a".repeat(40),
  ApiReleaseType: 2,
  SDKReleaseType: "beta",
  ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs/pull/123",
};

function ok(stdout = ""): CommandResult {
  return { exitCode: 0, stdout, stderr: "" };
}

function buildArtifact(outcome: string): string {
  return JSON.stringify({
    outcome,
    releasePlan: {
      release_plan_details: {
        ...PLAN_TARGET,
      },
    },
  });
}

function buildPlan(details: Record<string, unknown>): string {
  return JSON.stringify({
    release_plan_details: {
      ...PLAN_TARGET,
      IsManagementPlane: true,
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

  it("skips release plans retrieved directly by id", () => {
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
    for (const isPrivatePreview of [false, true]) {
      const target = {
        ...PLAN_TARGET,
        ...(isPrivatePreview
          ? {
              ApiReleaseType: 1,
              SpecAPIVersion: undefined,
              SpecCommitSHA: undefined,
              ActiveSpecPullRequest: "https://github.com/Azure/azure-rest-api-specs-pr/pull/123",
            }
          : {}),
      };
      const calls: string[][] = [];
      const runner = vi.fn((args: string[]) => {
        calls.push(args);
        return ok(buildPlan(target));
      });

      runUpdateSdkDetails(cliArgs, {
        readArtifact: vi.fn(() =>
          JSON.stringify({
            outcome: "created",
            releasePlan: { release_plan_details: target },
            details: {
              prUrl: target.ActiveSpecPullRequest,
              tspProjectPath: SPEC_PATH,
              apiVersion: PLAN_TARGET.SpecAPIVersion,
              specCommitSha: PLAN_TARGET.SpecCommitSHA,
              apiReleaseType: isPrivatePreview ? "Private Preview" : "Public Preview",
              sdkReleaseType: PLAN_TARGET.SDKReleaseType,
              targetReleaseMonth: "July 2026",
            },
          }),
        ),
        runner,
      });

      expect(calls).toEqual([
        ["release-plan", "get", "--release-plan-id", "12345", "--output", "json"],
        [
          "release-plan",
          "update",
          "--typespec-path",
          path.resolve(WORKSPACE, SPEC_PATH),
          "--workitem-id",
          "9001",
          "--sdk-type",
          "beta",
          "--pull-request",
          target.ActiveSpecPullRequest,
          ...(isPrivatePreview ? [] : ["--spec-commit-sha", PLAN_TARGET.SpecCommitSHA]),
          "--output",
          "json",
        ],
      ]);
    }
  });
});
