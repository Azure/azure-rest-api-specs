import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { REVIEW_REQUIRED_LABELS } from "../../shared/src/breaking-change.ts";
import type { Core, GitHubScriptArgs, WebhookEvent } from "./github.ts";

const execFileAsync = promisify(execFile);

// Keep this check dependency-free: it runs before the workflow installs packages.
export async function checkServiceCheckApplicability({
  context,
  core,
  cwd,
  checkName,
}: Pick<GitHubScriptArgs, "context" | "core"> & {
  cwd?: string;
  checkName: string;
}): Promise<boolean> {
  if (context.eventName !== "pull_request") {
    throw new Error("Service check applicability requires a pull_request event");
  }
  const { pull_request: pullRequest } = context.payload as WebhookEvent<"pull-request">;
  const base = pullRequest?.base.sha;
  const head = pullRequest?.head.sha;
  if (!base || !head || !/^[a-f0-9]{40}$/i.test(base) || !/^[a-f0-9]{40}$/i.test(head)) {
    throw new Error("Service check applicability requires valid pull request base and head SHAs");
  }

  const { stdout } = await execFileAsync(
    "git",
    ["diff", "--name-only", "-z", "--no-renames", `${base}...${head}`, "--"],
    { cwd, maxBuffer: 16 * 1024 * 1024 },
  );
  const files = stdout.split("\0").filter((file) => file.length > 0);
  const skillsOnly = files.length > 0 && files.every((file) => file.startsWith(".github/skills/"));

  if (skillsOnly) {
    const message =
      `${checkName} is not applicable: all changed paths are under .github/skills/. ` +
      "Skipping dependency installation and Swagger analysis.";
    core.info(message);
    await core.summary.addRaw(message).write();
  }
  core.setOutput("run-analysis", !skillsOnly);
  return !skillsOnly;
}

export function setNoReviewRequiredOutputs(core: Core): void {
  core.setOutput("breakingChangeReviewLabelName", REVIEW_REQUIRED_LABELS.BREAKING_CHANGE);
  core.setOutput("breakingChangeReviewLabelValue", "false");
  core.setOutput("versioningReviewLabelName", REVIEW_REQUIRED_LABELS.VERSIONING);
  core.setOutput("versioningReviewLabelValue", "false");
}
