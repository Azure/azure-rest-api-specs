import { readFileSync } from "node:fs";
import path from "node:path";
import process from "node:process";
import { parseArgs, type ParseArgsConfig } from "node:util";
import { createAzdskRunner, getReleasePlanById, parseAzdskResponse } from "./release-plan.ts";
import {
  apiReleaseTypeLabel,
  projectPath,
  releasePlanDetails,
  requiredPlanId,
  validateArtifactTarget,
} from "./spec-target.ts";
import type { AzsdkRunner, EnsureReleasePlanResult, OctokitLike, SdkInfo } from "./types.ts";
import { createOctokit } from "./typespec-project.ts";

type SdkLanguage = ".NET" | "Java" | "JavaScript" | "Python" | "Go";

const SDK_LANGUAGES: SdkLanguage[] = [".NET", "Java", "JavaScript", "Python", "Go"];

/**
 * ReleaseExclusionStatus values that indicate a language is NOT excluded from release.
 * Any other non-empty status (e.g. "MissingEmitterConfig") marks the language as excluded.
 */
const EXCLUDED_STATUSES = new Set(["Requested", "Approved", "missingemitterconfig"]);

interface GenerateSdkCliArgs {
  artifactFile: string;
  workspace: string;
}

/**
 * Injectable dependencies for the SDK generation orchestration, enabling unit tests to
 * substitute the file system, azsdk runner, and GitHub client.
 */
export interface GenerateSdkDependencies {
  readArtifact: (artifactFile: string) => string;
  runner: AzsdkRunner;
  octokit: OctokitLike;
}

export function parseCliArguments(argv: string[] = process.argv.slice(2)): GenerateSdkCliArgs {
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

function showHelp(): void {
  console.log("Release Plan Generate SDK Tool");
  console.log("");
  console.log("Usage:");
  console.log("  generate-sdk --artifact-file <path> [options]");
  console.log("");
  console.log("Options:");
  console.log("      --artifact-file   Path to release-plan.json artifact");
  console.log("  -w, --workspace       Path to local repo root (default: cwd)");
  console.log("                        Uses AZSDK environment variable for the azsdk executable");
  console.log("  -h, --help            Show help");
}

export async function getPrStatus(
  prUrl: string,
  octokit: OctokitLike,
): Promise<{ isValid: boolean; isMerged: boolean; isOpen: boolean; state: string }> {
  const match = prUrl.match(/^https:\/\/github\.com\/([^/]+)\/([^/]+)\/pull\/(\d+)$/i);
  if (!match) {
    return { isValid: false, isMerged: false, isOpen: false, state: "Unknown" };
  }

  const owner = match[1];
  const repo = match[2];
  const number = match[3];

  try {
    const pullNumber = Number.parseInt(number, 10);
    if (Number.isNaN(pullNumber)) {
      return { isValid: false, isMerged: false, isOpen: false, state: "Unknown" };
    }

    const response = await octokit.rest.pulls.get({
      owner,
      repo,
      pull_number: pullNumber,
    });

    const state = String(response.data.state ?? "Unknown").toUpperCase();
    const isMerged = Boolean(response.data.merged_at);
    return { isValid: true, isMerged, isOpen: state === "OPEN", state };
  } catch {
    return { isValid: false, isMerged: false, isOpen: false, state: "Unknown" };
  }
}

function findLanguageInfo(items: SdkInfo[], language: SdkLanguage): SdkInfo | undefined {
  return items.find((item) => {
    const name = item.Language ?? "";
    return name.trim().toLowerCase() === language.toLowerCase();
  });
}

/**
 * Determines whether a language is excluded from release based on its ReleaseExclusionStatus.
 * Languages without an emitter configuration (e.g. "MissingEmitterConfig") or otherwise
 * deliberately excluded cannot be generated and must be skipped.
 * @param languageInfo SDKInfo entry for a single language
 * @returns true when the language should be excluded from SDK generation
 */
export function isLanguageExcluded(languageInfo: SdkInfo): boolean {
  const exclusionStatus = (languageInfo.ReleaseExclusionStatus ?? "").trim().toLowerCase();
  return exclusionStatus.length > 0 && EXCLUDED_STATUSES.has(exclusionStatus);
}

export async function checkIfSdkNeedsToBeGenerated(params: {
  language: SdkLanguage;
  outcomeNormalized: string;
  sdkInfoItems: SdkInfo[];
  octokit: OctokitLike;
}): Promise<boolean> {
  const { language, outcomeNormalized, sdkInfoItems, octokit } = params;

  const languageInfo = findLanguageInfo(sdkInfoItems, language);

  // Exclusion must be validated before any other decision (including newly created plans),
  // since an excluded language cannot be generated and would fail the whole stage.
  if (languageInfo && isLanguageExcluded(languageInfo)) {
    const exclusionStatus = languageInfo.ReleaseExclusionStatus ?? "";
    console.log(
      `Skipping '${language}' because it is excluded from release (ExclusionStatus=${exclusionStatus}).`,
    );
    return false;
  }

  if (outcomeNormalized === "created") {
    return true;
  }

  if (!languageInfo) {
    console.log(`No SDKInfo found for '${language}'. Generating SDK.`);
    return true;
  }

  const releaseStatus = languageInfo.ReleaseStatus ?? "";
  const prUrl = languageInfo.SdkPullRequestUrl ?? "";

  if (releaseStatus.toLowerCase() === "released") {
    console.log(`Skipping '${language}' because SDK release status is Released.`);
    return false;
  }

  if (!prUrl) {
    console.log(`No SDK PR URL found for '${language}'. Generating SDK.`);
    return true;
  }

  const prStatus = await getPrStatus(prUrl, octokit);
  if (prStatus.isMerged) {
    console.log(`Skipping '${language}' because SDK PR is already merged: ${prUrl}`);
    console.log(
      "SDK was already generated and merged. If regeneration is required, run SDK generation manually using the azsdk agent.",
    );
    return false;
  }

  if (prStatus.isOpen) {
    console.log(`SDK PR is open for '${language}' (${prUrl}). Regenerating SDK for this language.`);
  } else if (prStatus.isValid) {
    console.log(
      `SDK PR for '${language}' is in state '${prStatus.state}' and not merged. Regenerating SDK for this language.`,
    );
  } else {
    console.error(
      `SDK PR status for '${language}' could not be determined. Skipping SDK generation.`,
    );
    return false;
  }

  return true;
}

export async function mainGenerateSdk(): Promise<void> {
  const args = parseCliArguments();
  await runGenerateSdk(args, {
    readArtifact: (artifactFile: string) => readFileSync(artifactFile, "utf8"),
    runner: createAzdskRunner(),
    octokit: createOctokit(undefined),
  });
}

export async function runGenerateSdk(
  args: GenerateSdkCliArgs,
  deps: GenerateSdkDependencies,
): Promise<void> {
  const { readArtifact, runner, octokit } = deps;
  const languages = SDK_LANGUAGES;

  const artifactRaw = readArtifact(args.artifactFile);
  const artifact = JSON.parse(artifactRaw) as EnsureReleasePlanResult;

  const outcome = artifact.outcome;
  console.log(`Outcome: ${outcome}`);
  if (outcome === "not_found" || outcome === "stale_event") {
    console.log("No current release target from this event. Skipping SDK generation stage.");
    return;
  }
  if (!["created", "existing_by_id", "existing_by_pr", "existing_by_path"].includes(outcome)) {
    throw new Error("Unrecognized release-plan artifact outcome; refusing SDK generation.");
  }

  const artifactPlanDetails = releasePlanDetails(artifact.releasePlan);
  const releasePlanId = requiredPlanId(artifactPlanDetails.ReleasePlanId, "ReleasePlanId");
  const plan = getReleasePlanById(releasePlanId, runner);
  const freshDetails = releasePlanDetails(plan);
  if (apiReleaseTypeLabel(freshDetails.ApiReleaseType) === "Private Preview") {
    validateArtifactTarget(artifact, plan, args.workspace);
    console.log("Private preview plans are not eligible for automatic SDK generation.");
    return;
  }
  if (freshDetails.IsManagementPlane !== true) {
    console.log(
      "This release plan is not management plane and not eligible for auto SDK generation.",
    );
    return;
  }

  const planDetails = validateArtifactTarget(artifact, plan, args.workspace);
  const workItemId = requiredPlanId(planDetails.WorkItemId, "WorkItemId");
  const typespecProjectPath = projectPath(planDetails.APISpecProjectPath, args.workspace);
  const sdkReleaseType = planDetails.SDKReleaseType!;
  const apiVersion = planDetails.SpecAPIVersion!;
  const specCommitSha = planDetails.SpecCommitSHA!;
  console.log(`TypeSpec Project Path: ${typespecProjectPath}`);
  console.log(
    `ReleasePlanId: ${releasePlanId}; API version: ${apiVersion}; spec commit: ${specCommitSha}`,
  );
  console.log(`SDK release type: ${sdkReleaseType}`);

  const sdkInfoItems = planDetails.SDKInfo ?? [];
  const outcomeNormalized = outcome.toLowerCase();

  for (const language of languages) {
    console.log(`Checking if SDK needs to be generated for language '${language}'.`);
    const shouldGenerate = await checkIfSdkNeedsToBeGenerated({
      language,
      outcomeNormalized,
      sdkInfoItems,
      octokit,
    });

    if (!shouldGenerate) {
      console.log(`SDK generation is not required for language '${language}'.`);
      continue;
    }

    console.log(`Generating SDK for language '${language}'.`);
    const generateResult = runner([
      "spec-workflow",
      "generate-sdk",
      "--typespec-project",
      typespecProjectPath,
      "--release-type",
      sdkReleaseType,
      "--language",
      language,
      "--workitem-id",
      workItemId,
      "--api-version",
      apiVersion,
      "--spec-commit-sha",
      specCommitSha,
      "--require-merged-spec",
      "true",
      "--output",
      "json",
    ]);

    try {
      const response = parseAzdskResponse(generateResult, "spec-workflow generate-sdk");
      if (response?.status !== "Success") {
        throw new Error("azsdk did not return a successful SDK generation response.");
      }
    } catch (error) {
      throw new Error(`SDK generation failed for language '${language}'. ${String(error)}`, {
        cause: error,
      });
    }
    console.log(`SDK generation succeeded for language '${language}'.`);
    console.log(generateResult.stdout.trim());
  }

  console.log("SDK generation stage completed successfully.");
}
