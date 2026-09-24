import { isFullGitSha } from "@azure-tools/specs-shared/git";
import { spawnSync } from "node:child_process";
import path from "node:path";
import type {
  ApiReleaseType,
  CommandResult,
  EnsureReleasePlanResult,
  ReleasePlanData,
  ReleasePlanDetails,
} from "./types.ts";

export function assertApiVersion(value: unknown): asserts value is string {
  if (typeof value !== "string" || !/^\d{4}-\d{2}-\d{2}(?:-preview)?$/.test(value)) {
    throw new Error(
      `API version '${String(value)}' must use YYYY-MM-DD or YYYY-MM-DD-preview format`,
    );
  }
}

export function assertSpecCommitSha(value: unknown): asserts value is string {
  if (typeof value !== "string" || !isFullGitSha(value)) {
    throw new Error("The spec commit SHA must be a full 40-character hexadecimal commit SHA.");
  }
}

export type GitRunner = (workspace: string, args: string[]) => CommandResult;

export const runGit: GitRunner = (workspace, args) => {
  const result = spawnSync("git", ["--no-optional-locks", "-C", workspace, ...args], {
    encoding: "utf8",
    env: { ...process.env, GIT_NO_LAZY_FETCH: "1" },
  });
  return {
    exitCode: result.status ?? 1,
    stdout: result.stdout || "",
    stderr: result.error?.message || result.stderr || "",
  };
};

/** Verify the caller's checkout without checking out, fetching, stashing, or resetting it. */
export function assertCleanSpecCheckout(
  workspace: string,
  specCommitSha: string,
  git: GitRunner = runGit,
): void {
  assertSpecCommitSha(specCommitSha);
  const head = git(workspace, ["rev-parse", "HEAD"]);
  if (head.exitCode !== 0 || head.stdout.trim().toLowerCase() !== specCommitSha.toLowerCase()) {
    throw new Error(
      `The workspace HEAD must equal the selected spec commit ${specCommitSha}. Prepare a separate checkout at that commit; automation will not switch it. ${head.stderr}`,
    );
  }
  const status = git(workspace, ["status", "--porcelain=v1", "--untracked-files=all"]);
  if (status.exitCode !== 0 || status.stdout.trim()) {
    throw new Error(`The spec checkout must be clean before using its metadata. ${status.stderr}`);
  }
}

/** Reject rollback, divergent history, and missing/shallow history instead of guessing. */
export function compareSpecCommits(
  workspace: string,
  storedSha: string,
  eventSha: string,
  git: GitRunner = runGit,
): "same" | "advance" | "stale" {
  assertSpecCommitSha(storedSha);
  assertSpecCommitSha(eventSha);
  if (storedSha.toLowerCase() === eventSha.toLowerCase()) {
    return "same";
  }

  const isAncestor = (ancestor: string, descendant: string): boolean => {
    const result = git(workspace, ["merge-base", "--is-ancestor", ancestor, descendant]);
    if (result.exitCode !== 0 && result.exitCode !== 1) {
      throw new Error(`Cannot establish spec commit ancestry. ${result.stderr}`);
    }
    return result.exitCode === 0;
  };
  if (isAncestor(storedSha, eventSha)) {
    return "advance";
  }
  if (isAncestor(eventSha, storedSha)) {
    return "stale";
  }
  throw new Error(
    "Spec commit history is divergent or incomplete; the release target was not changed.",
  );
}

/** The CLI serializes ApiReleaseType as an enum; accept its numeric and named forms. */
export function apiReleaseTypeLabel(value: unknown): ApiReleaseType | undefined {
  switch (String(value).replace(/\s/g, "").toLowerCase()) {
    case "1":
    case "privatepreview":
    case "apexprivatepreview":
      return "Private Preview";
    case "2":
    case "publicpreview":
    case "apexpublicpreview":
      return "Public Preview";
    case "3":
    case "ga":
      return "GA";
    default:
      return undefined;
  }
}

export function projectPath(value: unknown, workspace: string): string {
  if (typeof value !== "string" || !value.trim()) {
    throw new Error("The release target must contain a TypeSpec project path.");
  }
  const resolved = path.resolve(workspace, value.replace(/\\/g, "/"));
  const relative = path.relative(path.resolve(workspace), resolved);
  if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) {
    throw new Error("The TypeSpec project must be inside the specified workspace.");
  }
  return resolved;
}

export function releasePlanDetails(plan: ReleasePlanData | null | undefined): ReleasePlanDetails {
  const details = plan?.release_plan_details;
  if (!details || typeof details !== "object" || Array.isArray(details)) {
    throw new Error("The azsdk response must contain release_plan_details.");
  }
  return details;
}

export function requiredPlanId(value: unknown, field: string): string {
  const id = typeof value === "number" || typeof value === "string" ? String(value) : "";
  if (!/^[1-9]\d*$/.test(id)) {
    throw new Error(`The release plan must contain a valid ${field}.`);
  }
  return id;
}

/** Compare the immutable artifact selection with a freshly fetched plan, never local defaults. */
export function validateArtifactTarget(
  artifact: EnsureReleasePlanResult,
  plan: ReleasePlanData,
  workspace: string,
): ReleasePlanDetails {
  const snapshot = releasePlanDetails(artifact.releasePlan);
  const fresh = releasePlanDetails(plan);
  const isPrivatePreview = apiReleaseTypeLabel(snapshot.ApiReleaseType) === "Private Preview";
  for (const details of [snapshot, fresh]) {
    assertApiVersion(details.SpecAPIVersion);
    if (!isPrivatePreview) {
      assertSpecCommitSha(details.SpecCommitSHA);
    }
    projectPath(details.APISpecProjectPath, workspace);
    requiredPlanId(details.ReleasePlanId, "ReleasePlanId");
    requiredPlanId(details.WorkItemId, "WorkItemId");
    if (details.SDKReleaseType !== "beta" && details.SDKReleaseType !== "stable") {
      throw new Error("The release plan must explicitly set SDKReleaseType to beta or stable.");
    }
    if (!apiReleaseTypeLabel(details.ApiReleaseType) || !details.ActiveSpecPullRequest) {
      throw new Error("The release target must contain an API release type and linked spec PR.");
    }
  }
  if (
    String(snapshot.ReleasePlanId) !== String(fresh.ReleasePlanId) ||
    String(snapshot.WorkItemId) !== String(fresh.WorkItemId) ||
    snapshot.SpecAPIVersion !== fresh.SpecAPIVersion ||
    (!isPrivatePreview &&
      snapshot.SpecCommitSHA!.toLowerCase() !== fresh.SpecCommitSHA!.toLowerCase()) ||
    projectPath(snapshot.APISpecProjectPath, workspace) !==
      projectPath(fresh.APISpecProjectPath, workspace) ||
    snapshot.ActiveSpecPullRequest !== fresh.ActiveSpecPullRequest ||
    snapshot.SDKReleaseType !== fresh.SDKReleaseType ||
    apiReleaseTypeLabel(snapshot.ApiReleaseType) !== apiReleaseTypeLabel(fresh.ApiReleaseType)
  ) {
    throw new Error(
      "The release plan target changed since discovery; refusing this stale artifact.",
    );
  }

  const selection = artifact.details;
  if (selection && "apiVersion" in selection) {
    if (!isPrivatePreview) {
      assertSpecCommitSha(selection.specCommitSha);
    }
    if (
      selection.apiVersion !== fresh.SpecAPIVersion ||
      (!isPrivatePreview &&
        selection.specCommitSha.toLowerCase() !== fresh.SpecCommitSHA!.toLowerCase()) ||
      projectPath(selection.tspProjectPath, workspace) !==
        projectPath(fresh.APISpecProjectPath, workspace) ||
      selection.prUrl !== fresh.ActiveSpecPullRequest ||
      selection.apiReleaseType !== apiReleaseTypeLabel(fresh.ApiReleaseType) ||
      selection.sdkReleaseType !== fresh.SDKReleaseType
    ) {
      throw new Error("The release plan does not match the artifact's explicit spec target.");
    }
  } else if (selection && selection.releasePlanId !== String(fresh.ReleasePlanId)) {
    throw new Error("The release plan does not match the artifact's requested release plan ID.");
  }
  return fresh;
}
