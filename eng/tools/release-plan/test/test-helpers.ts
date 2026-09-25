import path from "node:path";
import { vi } from "vitest";
import type { GitRunner } from "../src/spec-target.ts";
import type { CommandResult, ReleasePlanCommandContext, ReleasePlanData } from "../src/types.ts";

export const WORKSPACE = path.resolve("/repo/root");
export const SPEC_PATH = "specification/contoso/Contoso.Management";
export const API_VERSION = "2026-01-01-preview";
export const OLD_SHA = "a".repeat(40);
export const SPEC_SHA = "b".repeat(40);
export const PR_URL = "https://github.com/Azure/azure-rest-api-specs/pull/123";

export const context: ReleasePlanCommandContext = {
  prUrl: PR_URL,
  workspace: WORKSPACE,
  tspProjectPath: SPEC_PATH,
  apiVersion: API_VERSION,
  specCommitSha: SPEC_SHA,
  apiReleaseType: "Public Preview",
  sdkReleaseType: "beta",
  targetMonth: "July 2026",
  testReleasePlan: false,
};

export function plan(details: Record<string, unknown> = {}): ReleasePlanData {
  return {
    operation_status: "Succeeded",
    release_plan_details: {
      ReleasePlanId: "12345",
      WorkItemId: "9001",
      APISpecProjectPath: SPEC_PATH,
      SpecAPIVersion: API_VERSION,
      SpecCommitSHA: SPEC_SHA,
      ActiveSpecPullRequest: PR_URL,
      ApiReleaseType: 2,
      SDKReleaseType: "beta",
      IsManagementPlane: true,
      Status: "In progress",
      SDKInfo: [],
      ...details,
    },
  };
}

export function ok(
  value: unknown = { status: "Success", operation_status: "Succeeded" },
): CommandResult {
  return { exitCode: 0, stdout: JSON.stringify(value), stderr: "" };
}

/** All Git boundaries are mocked: tests never inspect or mutate the contributor's checkout. */
export function cleanGit(sha = SPEC_SHA) {
  return vi.fn<GitRunner>((_workspace, args) => {
    if (args[0] === "rev-parse") {
      return { exitCode: 0, stdout: sha, stderr: "" };
    }
    if (args[0] === "status") {
      return { exitCode: 0, stdout: "", stderr: "" };
    }
    if (args[0] === "merge-base") {
      return {
        exitCode: args[2] === OLD_SHA && args[3] === SPEC_SHA ? 0 : 1,
        stdout: "",
        stderr: "",
      };
    }
    throw new Error(`Unexpected Git command: ${args.join(" ")}`);
  });
}
