import { SpecGenSdkArtifactInfoSchema, sdkLabels } from "../../shared/src/sdk-types.ts";
import { getAdoBuildInfoFromUrl, getAzurePipelineArtifact } from "./artifacts.ts";
import { extractInputs } from "./context.ts";
import type { Core, GitHubScriptArgs, WebhookEvent } from "./github.ts";
import { LabelAction } from "./label.ts";
import {
  isPrivateSdkRepository,
  loadPrivateSdkChecks,
  readPrivateSdkArtifact,
} from "./sdk-check-metadata.ts";

const SUPPORTED_TARGET_BRANCHES = new Set(["main", "RPSaaSMaster"]);

export type SdkName = import("../../shared/src/sdk-types.ts").SdkName;

export type ArtifactResource = {
  downloadUrl?: string;
};

export type Artifacts = {
  resource?: ArtifactResource;
};

export async function getLabelAndAction({ github, context, core }: GitHubScriptArgs): Promise<{
  labelName: string | undefined;
  labelAction: LabelAction;
  issueNumber: number;
  headSha?: string;
}> {
  if (isPrivateSdkRepository(context.repo.owner, context.repo.repo)) {
    const { check_run: triggerCheck } = context.payload as WebhookEvent<"check-run">;
    const observation = await loadPrivateSdkChecks({
      github,
      core,
      ...context.repo,
      headSha: triggerCheck.head_sha,
      eventCheckId: triggerCheck.id,
    });
    if (!observation) {
      return { labelName: undefined, labelAction: LabelAction.None, issueNumber: NaN };
    }
    const { checks, allChecks, pr, prNumber } = observation;
    const trigger = allChecks.find((check) => check.id === triggerCheck.id);
    const matching = checks.filter(
      (check) => check.name === trigger?.name || check.details_url === trigger?.details_url,
    );
    if (matching.length !== 1)
      throw new Error("Cannot correlate metadata event to current SDK build");
    const native = matching[0];
    if (native.status !== "completed") {
      core.info("Native SDK validation is still running; preserving existing labels.");
      return {
        labelName: undefined,
        labelAction: LabelAction.None,
        headSha: native.head_sha,
        issueNumber: prNumber,
      };
    }
    const artifact = readPrivateSdkArtifact(native, allChecks, prNumber);
    const labelName = sdkLabels[artifact.language].breakingChange;
    const labelAction =
      !labelName || artifact.labelAction === undefined
        ? LabelAction.None
        : artifact.labelAction
          ? SUPPORTED_TARGET_BRANCHES.has(pr.base.ref)
            ? LabelAction.Add
            : LabelAction.None
          : LabelAction.Remove;
    return { labelName, labelAction, headSha: artifact.headSha, issueNumber: prNumber };
  }
  const inputs = await extractInputs(github, context, core);
  const details_url = inputs.details_url;
  if (!details_url) {
    throw new Error(`Required inputs are not valid: details_url:${details_url}`);
  }
  const result = await getLabelAndActionImpl({
    details_url,
    core,
  });

  // This requirement only scopes label additions; target-branch handling for removals will be added later.
  if (result.issueNumber > 0 && result.labelAction === LabelAction.Add) {
    const { data: pullRequest } = await github.rest.pulls.get({
      ...context.repo,
      pull_number: result.issueNumber,
    });
    const targetBranch = pullRequest.base.ref;
    core.info(`PR target branch: ${targetBranch}`);

    if (!SUPPORTED_TARGET_BRANCHES.has(targetBranch)) {
      core.info(`Skipping SDK breaking change label addition for unsupported target branch.`);
      result.labelAction = LabelAction.None;
    }
  }

  core.setOutput("head_sha", result.headSha);
  core.setOutput("issue_number", result.issueNumber);
  return result;
}

export async function getLabelAndActionImpl({
  details_url,
  core,
  retryOptions = {},
}: {
  details_url: string;
  core: Core;
  retryOptions?: import("./retries.ts").RetryOptions;
}): Promise<{
  labelName: string | undefined;
  labelAction: LabelAction;
  headSha: string;
  issueNumber: number;
}> {
  // Override default logger from console.log to core.info
  retryOptions = { logger: core.info, ...retryOptions };

  let head_sha = "";
  let issue_number = NaN;
  let labelAction;

  let labelName: string | undefined = "";
  const buildInfo = getAdoBuildInfoFromUrl(details_url);
  const ado_project_url = buildInfo.projectUrl;
  const ado_build_id = buildInfo.buildId;
  const artifactName = "spec-gen-sdk-artifact";
  const artifactFileName = artifactName + ".json";
  const result = await getAzurePipelineArtifact({
    ado_build_id,
    ado_project_url,
    artifactName,
    artifactFileName,
    core,
    retryOptions,
    fallbackToFailedArtifact: true,
    token: process.env.ADO_TOKEN,
  });
  // Parse the JSON data
  if (!result.artifactData) {
    core.warning(
      `Artifact '${artifactName}' not found in the build with details_url:${details_url} or failed to download it.`,
    );
  } else {
    core.info(`Artifact content: ${result.artifactData}`);
    // Parse the JSON data
    const specGenSdkArtifactInfo = SpecGenSdkArtifactInfoSchema.parse(
      JSON.parse(result.artifactData),
    );
    const labelActionText = specGenSdkArtifactInfo.labelAction;

    head_sha = specGenSdkArtifactInfo.headSha;

    issue_number = parseInt(specGenSdkArtifactInfo.prNumber ?? "", 10);
    if (!issue_number) {
      core.warning(
        `No PR number found in the artifact '${artifactName}' with details_url:${details_url}.`,
      );
    }

    const breakingChangeLanguage: SdkName = specGenSdkArtifactInfo.language;
    if (breakingChangeLanguage) {
      labelName = sdkLabels[`${breakingChangeLanguage}`].breakingChange;
    }

    // Set label action and name based on the artifacts
    if (labelActionText === true) {
      labelAction = LabelAction.Add;
    } else if (labelActionText === false) {
      labelAction = LabelAction.Remove;
    }
  }

  if (!labelAction || !labelName) {
    core.info("No label action or name found, defaulting to None");
    labelAction = LabelAction.None;
  }

  return { labelName, labelAction, headSha: head_sha, issueNumber: issue_number };
}
