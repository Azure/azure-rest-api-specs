import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import type { CommandResult } from "../src/types.ts";
import { runUpdateSdkDetails } from "../src/update-sdk-details.ts";

const WORKSPACE = path.resolve("/repo/root");
const SPEC_PATH = "specification/contoso/Contoso.Management";

function ok(stdout = ""): CommandResult {
  return { exitCode: 0, stdout, stderr: "" };
}

function buildArtifact(outcome: string): string {
  return JSON.stringify({
    outcome,
    releasePlan: {
      release_plan_details: {
        ReleasePlanId: "12345",
        WorkItemId: "9001",
        APISpecProjectPath: SPEC_PATH,
      },
    },
  });
}

function buildPlan(details: Record<string, unknown>): string {
  return JSON.stringify({
    release_plan_details: {
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
      return ok();
    });

    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("created")),
      runner,
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
    ]);
  });
});
