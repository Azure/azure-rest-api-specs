import { readFileSync } from "node:fs";
import path from "node:path";
import process from "node:process";
import { parseArgs, type ParseArgsConfig } from "node:util";
import { getReleasePlanById, runAzdskCommand } from "./release-plan.ts";
import type { OctokitLike } from "./types.ts";
import { createOctokit } from "./typespec-project.ts";

type SdkLanguage = ".NET" | "Java" | "JavaScript" | "Python" | "Go";

interface GenerateSdkCliArgs {
  artifactFile: string;
  azsdkPath?: string;
}

type SdkInfoItem = Record<string, unknown>;

function toStringValue(value: unknown): string {
  if (value === null || value === undefined) {
    return "";
  }
  if (
    typeof value === "string" ||
    typeof value === "number" ||
    typeof value === "boolean" ||
    typeof value === "bigint"
  ) {
    return String(value);
  }
  return "";
}

function parseCliArguments(argv: string[] = process.argv.slice(2)): GenerateSdkCliArgs {
  const options: ParseArgsConfig = {
    args: argv,
    options: {
      "artifact-file": {
        type: "string",
      },
      "azsdk-path": {
        type: "string",
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

  const azsdkPath = String(values["azsdk-path"] ?? "").trim() || undefined;

  return {
    artifactFile: path.resolve(artifactFile),
    azsdkPath,
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
  console.log("      --azsdk-path      Absolute path to the azsdk executable");
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

function parseSdkInfoItems(sdkInfo: unknown): SdkInfoItem[] {
  if (Array.isArray(sdkInfo)) {
    return sdkInfo as SdkInfoItem[];
  }

  if (typeof sdkInfo !== "string" || !sdkInfo.trim()) {
    return [];
  }

  try {
    const parsed = JSON.parse(sdkInfo);
    if (Array.isArray(parsed)) {
      return parsed as SdkInfoItem[];
    }
  } catch {
    // Fall through to empty result when the SDKInfo payload is malformed.
  }

  return [];
}

function findLanguageInfo(items: SdkInfoItem[], language: SdkLanguage): SdkInfoItem | undefined {
  return items.find((item) => {
    const name = toStringValue((item as Record<string, unknown>).Language);
    return name.trim().toLowerCase() === language.toLowerCase();
  });
}

export async function checkIfSdkNeedsToBeGenerated(params: {
  language: SdkLanguage;
  outcomeNormalized: string;
  sdkInfoItems: SdkInfoItem[];
  octokit: OctokitLike;
}): Promise<boolean> {
  const { language, outcomeNormalized, sdkInfoItems, octokit } = params;

  if (outcomeNormalized === "created") {
    return true;
  }

  const languageInfo = findLanguageInfo(sdkInfoItems, language);
  if (!languageInfo) {
    console.log(`No SDKInfo found for '${language}'. Generating SDK.`);
    return true;
  }

  const releaseStatus = toStringValue(languageInfo.ReleaseStatus);
  const prUrl = toStringValue(languageInfo.SdkPullRequestUrl);

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
    console.log(
      `SDK PR status for '${language}' could not be determined. Proceeding with SDK generation.`,
    );
  }

  return true;
}

export async function mainGenerateSdk(): Promise<void> {
  const args = parseCliArguments();
  const octokit = createOctokit(undefined);
  const languages: SdkLanguage[] = [".NET", "Java", "JavaScript", "Python", "Go"];

  const artifactRaw = readFileSync(args.artifactFile, "utf8");
  const artifact = JSON.parse(artifactRaw) as Record<string, unknown>;

  const outcome = toStringValue(artifact.outcome);
  const artifactReleasePlan = (artifact.releasePlan ?? {}) as Record<string, unknown>;
  const artifactPlanDetails = (artifactReleasePlan.release_plan_details ?? {}) as Record<
    string,
    unknown
  >;

  const typespecProjectPath = toStringValue(artifactPlanDetails.APISpecProjectPath);

  const releasePlanId = toStringValue(artifactPlanDetails.ReleasePlanId);

  const workItemId = toStringValue(artifactPlanDetails.WorkItemId) || releasePlanId;

  console.log(`Outcome: ${outcome}`);
  console.log(`TypeSpec Project Path: ${typespecProjectPath}`);
  console.log(`ReleasePlanId: ${releasePlanId}`);

  if (outcome.toLowerCase() === "not_found" || !releasePlanId) {
    console.log("No release plan available for SDK generation. Skipping SDK generation stage.");
    return;
  }

  if (!workItemId) {
    throw new Error("Work item id could not be determined from release-plan artifact.");
  }

  let plan: Record<string, unknown> = getReleasePlanById(releasePlanId, args.azsdkPath);
  let planDetails = (plan.release_plan_details ?? {}) as Record<string, unknown>;
  console.log(`Release plan details: ${JSON.stringify(planDetails)}`);
  const isManagementPlane = Boolean(planDetails.IsManagementPlane);

  const sdkReleaseType = toStringValue(planDetails.SDKReleaseType);
  console.log(`SDK release type: ${sdkReleaseType}`);
  console.log(`Is management plane: ${isManagementPlane}`);
  if (!typespecProjectPath) {
    throw new Error(
      "TypeSpec project path could not be determined from artifact or release plan details.",
    );
  }

  if (!sdkReleaseType) {
    throw new Error("SDK release type could not be determined from release plan details.");
  }

  if (!isManagementPlane) {
    console.log(
      "This release plan is not management plane and not eligible for auto SDK generation.",
    );
    return;
  }

  let sdkInfoItems = parseSdkInfoItems(planDetails.SDKInfo);
  let shouldUpdateDetails = false;

  for (const language of languages) {
    const languageInfo = findLanguageInfo(sdkInfoItems, language);
    if (!languageInfo) {
      shouldUpdateDetails = true;
      console.log(
        `SDKInfo missing for language '${language}'. Will update release plan SDK details.`,
      );
      continue;
    }
    
    console.log(`Checking SDK details for language '${language}'.`);
    const packageName = toStringValue(languageInfo.PackageName);
    const exclusionStatus = toStringValue(languageInfo.ReleaseExclusionStatus);
    console.log(`     Package name: ${packageName}`);
    console.log(`     Exclusion status: ${exclusionStatus}`);

    if (!packageName) {
      shouldUpdateDetails = true;
      console.log(
        `Package name missing for language '${language}'. Will update release plan SDK details.`,
      );
    }

    if (exclusionStatus.toLowerCase() === "missingemitterconfig") {
      shouldUpdateDetails = true;
      console.log(
        `Language '${language}' has ExclusionStatus=MissingEmitterConfig. Will update release plan SDK details.`,
      );
    }
  }

  if (shouldUpdateDetails) {
    console.log("Running release plan update to refresh SDK details.");
    const updateResult = runAzdskCommand(
      [
        "release-plan",
        "update",
        "--typespec-path",
        typespecProjectPath,
        "--workitem-id",
        workItemId,
        "--sdk-type",
        sdkReleaseType,
      ],
      args.azsdkPath,
    );

    if (updateResult.exitCode !== 0) {
      throw new Error(
        `azsdk release-plan update failed. ${updateResult.stderr || updateResult.stdout}`,
      );
    }

    plan = getReleasePlanById(releasePlanId, args.azsdkPath);
    planDetails = (plan.release_plan_details ?? {}) as Record<string, unknown>;
    sdkInfoItems = parseSdkInfoItems(planDetails?.SDKInfo);
  }
  else {
    console.log("Release plan SDK details are up-to-date. No update required.");
  }

  const outcomeNormalized = outcome.toLowerCase();
  const failedLanguages: SdkLanguage[] = [];

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
    const generateResult = runAzdskCommand(
      [
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
      ],
      args.azsdkPath,
    );

    if (generateResult.exitCode !== 0) {
      console.log(`SDK generation failed for language '${language}'.`);
      if (generateResult.stderr.trim()) {
        console.log(generateResult.stderr.trim());
      } else if (generateResult.stdout.trim()) {
        console.log(generateResult.stdout.trim());
      }
      failedLanguages.push(language);
    } else {
      console.log(`SDK generation succeeded for language '${language}'.`);
      if (generateResult.stdout.trim()) {
        console.log(generateResult.stdout.trim());
      }
      if (generateResult.stderr.trim()) {
        console.log(generateResult.stderr.trim());
      }
    }
  }

  if (failedLanguages.length > 0) {
    throw new Error(`SDK generation failed for language(s): ${failedLanguages.join(", ")}`);
  }

  console.log("SDK generation stage completed successfully.");
}
