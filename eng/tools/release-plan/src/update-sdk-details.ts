import { readFileSync } from "node:fs";
import path from "node:path";
import process from "node:process";
import { parseArgs, type ParseArgsConfig } from "node:util";
import { createAzdskRunner, getReleasePlanById, parseAzdskResponse } from "./release-plan.ts";
import {
  apiReleaseTypeLabel,
  assertCleanSpecCheckout,
  projectPath,
  releasePlanDetails,
  requiredPlanId,
  validateArtifactTarget,
  type GitRunner,
} from "./spec-target.ts";
import type { AzsdkRunner, EnsureReleasePlanResult } from "./types.ts";

interface RefreshSdkDetailsCliArgs {
  artifactFile: string;
  workspace: string;
}

export interface RefreshSdkDetailsDependencies {
  readArtifact: (artifactFile: string) => string;
  runner: AzsdkRunner;
  git?: GitRunner;
}

function showHelp(): void {
  console.log("Release Plan Update SDK Details Tool");
  console.log("");
  console.log("Usage:");
  console.log("  update-sdk-details --artifact-file <path> [options]");
  console.log("");
  console.log("Options:");
  console.log("      --artifact-file   Path to release-plan.json artifact");
  console.log("  -w, --workspace       Path to local repo root (default: cwd)");
  console.log("  -h, --help            Show help");
}

export function parseRefreshCliArguments(
  argv: string[] = process.argv.slice(2),
): RefreshSdkDetailsCliArgs {
  const options: ParseArgsConfig = {
    args: argv,
    options: {
      "artifact-file": {
        type: "string",
      },
      workspace: {
        type: "string",
        short: "w",
        default: process.cwd(),
      },
      help: {
        type: "boolean",
        short: "h",
        default: false,
      },
    },
    allowPositionals: false,
    strict: true,
  };

  const { values } = parseArgs(options);

  if (values.help) {
    showHelp();
    process.exit(0);
  }

  const artifactFile = String(values["artifact-file"] ?? "").trim();
  if (!artifactFile) {
    throw new Error("--artifact-file is required.");
  }

  return {
    artifactFile: path.resolve(artifactFile),
    workspace: path.resolve(String(values.workspace ?? process.cwd())),
  };
}

function shouldRunForOutcome(outcome: string): boolean {
  const normalized = outcome.trim().toLowerCase();
  return (
    normalized === "created" || normalized === "existing_by_path" || normalized === "existing_by_pr"
  );
}

export function mainUpdateSdkDetails(): void {
  const args = parseRefreshCliArguments();
  runUpdateSdkDetails(args, {
    readArtifact: (artifactFile: string) => readFileSync(artifactFile, "utf8"),
    runner: createAzdskRunner(),
  });
}

export function runUpdateSdkDetails(
  args: RefreshSdkDetailsCliArgs,
  deps: RefreshSdkDetailsDependencies,
): void {
  const { readArtifact, runner } = deps;

  const artifactRaw = readArtifact(args.artifactFile);
  const artifact = JSON.parse(artifactRaw) as EnsureReleasePlanResult;

  const outcome = artifact.outcome;
  if (!shouldRunForOutcome(outcome)) {
    console.log(
      `Skipping SDK details update for outcome '${outcome}'. Only current discovery targets are eligible.`,
    );
    return;
  }

  const snapshot = releasePlanDetails(artifact.releasePlan);
  const releasePlanId = requiredPlanId(snapshot.ReleasePlanId, "ReleasePlanId");
  const plan = getReleasePlanById(releasePlanId, runner);
  const freshDetails = releasePlanDetails(plan);
  const releasePlanStatus = (freshDetails.Status ?? "").trim().toLowerCase();

  if (releasePlanStatus !== "in progress") {
    console.log(
      `Release plan status is '${freshDetails.Status ?? ""}'. SDK details update only runs when status is 'In progress'.`,
    );
    return;
  }

  const planDetails = validateArtifactTarget(artifact, plan, args.workspace);
  const isPrivatePreview = apiReleaseTypeLabel(planDetails.ApiReleaseType) === "Private Preview";
  const workItemId = requiredPlanId(planDetails.WorkItemId, "WorkItemId");
  const typespecProjectPath = projectPath(planDetails.APISpecProjectPath, args.workspace);
  const sdkReleaseType = planDetails.SDKReleaseType!;
  // The artifact is the observed precondition, not a new pin learned from the fresh lookup.
  const specCommitSha = snapshot.SpecCommitSHA!;
  if (!isPrivatePreview) {
    assertCleanSpecCheckout(args.workspace, specCommitSha, deps.git);
  }
  const targetArgs = isPrivatePreview
    ? []
    : [
        "--api-version",
        snapshot.SpecAPIVersion!,
        "--spec-commit-sha",
        specCommitSha,
        "--confirm-target",
        "--expected-spec-commit-sha",
        specCommitSha,
      ];
  console.log("Running release plan update for an in-progress release plan.");
  const updateResult = runner([
    "release-plan",
    "update",
    "--typespec-path",
    typespecProjectPath,
    "--workitem-id",
    workItemId,
    "--sdk-type",
    sdkReleaseType,
    "--pull-request",
    planDetails.ActiveSpecPullRequest!,
    ...targetArgs,
    "--output",
    "json",
  ]);

  const response = parseAzdskResponse(updateResult, "release-plan update");
  if (!response) {
    throw new Error("azsdk release-plan update did not return a confirmed release plan.");
  }
  validateArtifactTarget(artifact, response, args.workspace);
  if (!isPrivatePreview) {
    assertCleanSpecCheckout(args.workspace, specCommitSha, deps.git);
  }

  // Re-fetch once so completion is visible in logs and failures are surfaced early.
  validateArtifactTarget(artifact, getReleasePlanById(releasePlanId, runner), args.workspace);
  console.log(
    `SDK details update completed for release plan '${releasePlanId}' (sdkType='${sdkReleaseType}').`,
  );
}
