import { SpecGenSdkArtifactInfoSchema, sdkLabels } from "../../shared/src/sdk-types.ts";
import { getAdoBuildInfoFromUrl, getAzurePipelineArtifact } from "./artifacts.ts";
import { extractInputs } from "./context.ts";
import type { Core } from "./github.ts";
import { LabelAction } from "./label.ts";

const SUPPORTED_TARGET_BRANCHES = new Set(["main", "RPSaaSMaster"]);

export type SdkName = import("../../shared/src/sdk-types.ts").SdkName;

export type ArtifactResource = {
  downloadUrl?: string;
};

export type Artifacts = {
  resource?: ArtifactResource;
};

export async function getLabelAndAction({
  github,
  context,
  core,
}: import("@actions/github-script").AsyncFunctionArguments): Promise<{
  labelName: string | undefined;
  labelAction: LabelAction;
  issueNumber: number;
}> {
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
