import path from "node:path";
import { describe, expect, it, vi } from "vitest";
import type { CommandResult } from "../src/types.ts";
import { runUpdateSdkDetails } from "../src/update-sdk-details.ts";

const WORKSPACE = path.resolve("/repo/root");
const SPEC_PATH = "specification/contoso/Contoso.Management";
const SPEC_SHA = "a".repeat(40);
const SPEC_PR = "https://github.com/Azure/azure-rest-api-specs/pull/123";

function ok(stdout = ""): CommandResult {
  return { exitCode: 0, stdout, stderr: "" };
}

function buildArtifact(
  outcome: string,
  apiVersion = "2026-06-01-preview",
  apiReleaseType = "Public Preview",
): string {
  return JSON.stringify({
    outcome,
    releasePlan: {
      release_plan_details: {
        ReleasePlanId: "12345",
        WorkItemId: "9001",
        APISpecProjectPath: SPEC_PATH,
      },
    },
    details:
      outcome === "existing_by_id"
        ? { releasePlanId: "12345" }
        : {
            prUrl: SPEC_PR,
            tspProjectPath: SPEC_PATH,
            apiVersion,
            specCommitSha: SPEC_SHA,
            apiReleaseType,
            sdkReleaseType: "beta",
            targetReleaseMonth: "July 2026",
          },
  });
}

function buildPlan(details: Record<string, unknown> = {}): string {
  return JSON.stringify({
    release_plan_details: {
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

  it("accepts release plans retrieved directly by id", () => {
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

    expect(runner).toHaveBeenCalledOnce();
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

  it.each(["created", "existing_by_pr", "existing_by_path"])(
    "passes the triggering commit and PR into the existing %s update",
    (outcome) => {
      const runner = vi.fn((args: string[]) => (args[1] === "get" ? ok(buildPlan()) : ok()));
      runUpdateSdkDetails(cliArgs, {
        readArtifact: vi.fn(() => buildArtifact(outcome)),
        runner,
      });
      expect(runner.mock.calls.map(([args]) => args[1])).toEqual(["get", "update", "get"]);
      expect(runner).toHaveBeenCalledWith([
        "release-plan",
        "update",
        "--typespec-path",
        path.resolve(WORKSPACE, SPEC_PATH),
        "--workitem-id",
        "9001",
        "--sdk-type",
        "beta",
        "--spec-commit-sha",
        SPEC_SHA,
        "--pull-request",
        SPEC_PR,
      ]);
    },
  );

  it("does not advance the target in an existing-ID update", () => {
    const runner = vi.fn((args: string[]) => (args[1] === "get" ? ok(buildPlan()) : ok()));
    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("existing_by_id")),
      runner,
    });
    expect(runner).toHaveBeenCalledWith([
      "release-plan",
      "update",
      "--typespec-path",
      path.resolve(WORKSPACE, SPEC_PATH),
      "--workitem-id",
      "9001",
      "--sdk-type",
      "beta",
    ]);
    expect(runner.mock.calls.some(([args]) => args.includes("--spec-commit-sha"))).toBe(false);
  });

  it("allows empty API versions without passing an override", () => {
    const runner = vi.fn((args: string[]) =>
      args[1] === "get" ? ok(buildPlan({ SpecAPIVersion: "" })) : ok(),
    );
    runUpdateSdkDetails(cliArgs, {
      readArtifact: vi.fn(() => buildArtifact("existing_by_path", "")),
      runner,
    });
    expect(runner).toHaveBeenCalledWith(expect.arrayContaining(["--spec-commit-sha", SPEC_SHA]));
    expect(runner.mock.calls.some(([args]) => args.includes("--api-version"))).toBe(false);
  });

  it("keeps the existing private-preview update payload without a public commit pin", () => {
    const runner = vi.fn((args: string[]) => (args[1] === "get" ? ok(buildPlan()) : ok()));
    runUpdateSdkDetails(cliArgs, {
      readArtifact: () => buildArtifact("created", "", "Private Preview"),
      runner,
    });
    expect(runner.mock.calls.map(([args]) => args[1])).toEqual(["get", "update", "get"]);
    expect(runner).toHaveBeenCalledWith([
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

  it("reports a failed update without continuing to the completion lookup", () => {
    const runner = vi.fn((args: string[]) =>
      args[1] === "get" ? ok(buildPlan()) : { exitCode: 1, stdout: "", stderr: "update failed" },
    );
    expect(() =>
      runUpdateSdkDetails(cliArgs, {
        readArtifact: vi.fn(() => buildArtifact("created")),
        runner,
      }),
    ).toThrow("update failed");
    expect(runner.mock.calls.map(([args]) => args[1])).toEqual(["get", "update"]);
  });
});
