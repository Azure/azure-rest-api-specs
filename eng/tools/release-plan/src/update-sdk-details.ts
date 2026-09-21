import { readFileSync } from "node:fs";
import path from "node:path";
import process from "node:process";
import { parseArgs, type ParseArgsConfig } from "node:util";
import { createAzdskRunner, getReleasePlanById } from "./release-plan.ts";
import { resolveTypespecProjectPath, toStringValue } from "./sdk-workflow-common.ts";
import type {
  AzsdkRunner,
  EnsureReleasePlanResult,
  ReleasePlanData,
  ReleasePlanDetails,
} from "./types.ts";

interface RefreshSdkDetailsCliArgs {
  artifactFile: string;
  workspace: string;
}

export interface RefreshSdkDetailsDependencies {
  readArtifact: (artifactFile: string) => string;
  runner: AzsdkRunner;
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
  const artifactReleasePlan = artifact.releasePlan;
  const artifactPlanDetails = artifactReleasePlan?.release_plan_details;

  const releasePlanId = toStringValue(artifactPlanDetails?.ReleasePlanId);
  const workItemId = toStringValue(artifactPlanDetails?.WorkItemId) || releasePlanId;
  const typespecProjectPath = resolveTypespecProjectPath(
    artifactPlanDetails?.APISpecProjectPath ?? "",
    args.workspace,
  );

  if (!shouldRunForOutcome(outcome) || !releasePlanId) {
    console.log(
      `Skipping SDK details update for outcome '${outcome}'. Only created/existing release plans are eligible.`,
    );
    return;
  }

  if (!workItemId) {
    throw new Error("Work item id could not be determined from release-plan artifact.");
  }

  let plan: ReleasePlanData = getReleasePlanById(releasePlanId, runner);
  let planDetails: ReleasePlanDetails | undefined = plan.release_plan_details;

  const sdkReleaseType = planDetails?.SDKReleaseType ?? "";
  const releasePlanStatus = (planDetails?.Status ?? "").trim().toLowerCase();

  if (releasePlanStatus !== "in progress") {
    console.log(
      `Release plan status is '${planDetails?.Status ?? ""}'. SDK details update only runs when status is 'In progress'.`,
    );
    return;
  }

  if (!typespecProjectPath) {
    throw new Error(
      "TypeSpec project path could not be determined from artifact or release plan details.",
    );
  }

  if (!sdkReleaseType) {
    throw new Error("SDK release type could not be determined from release plan details.");
  }

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
  ]);

  if (updateResult.exitCode !== 0) {
    throw new Error(
      `azsdk release-plan update failed. ${updateResult.stderr || updateResult.stdout}`,
    );
  }

  // Re-fetch once so completion is visible in logs and failures are surfaced early.
  plan = getReleasePlanById(releasePlanId, runner);
  planDetails = plan.release_plan_details;
  console.log(
    `SDK details update completed for release plan '${releasePlanId}' (sdkType='${planDetails?.SDKReleaseType ?? ""}').`,
  );
}
