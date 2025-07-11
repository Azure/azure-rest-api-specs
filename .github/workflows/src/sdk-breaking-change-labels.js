// @ts-check
import { sdkLabels } from "../../shared/src/sdk-types.js";
import { getAdoBuildInfoFromUrl, getAzurePipelineArtifact } from "./artifacts.js";
import { extractInputs } from "./context.js";
import { LabelAction } from "./label.js";

/**
 * @typedef {import("../../shared/src/sdk-types.js").SdkName} SdkName
 */

/**
 * @typedef {Object} ArtifactResource
 * @property {string} [downloadUrl]
 */

/**
 * @typedef {Object} Artifacts
 * @property {ArtifactResource} [resource]
 */

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{labelName: string | undefined, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndAction({ github, context, core }) {
  const inputs = await extractInputs(github, context, core);
  const details_url = inputs.details_url;
  if (!details_url) {
    throw new Error(`Required inputs are not valid: details_url:${details_url}`);
  }
  return await getLabelAndActionImpl({
    details_url,
    core,
  });
}

/**
 * @param {Object} params
 * @param {string} params.details_url
 * @param {typeof import("@actions/core")} params.core
 * @param {import('./retries.js').RetryOptions} [params.retryOptions]
 * @returns {Promise<{labelName: string | undefined, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndActionImpl({ details_url, core, retryOptions = {} }) {
  // Override default logger from console.log to core.info
  retryOptions = { logger: core.info, ...retryOptions };

  let issue_number = NaN;
  let labelAction;
  /** @type {String | undefined} */
  let labelName = "";
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
    const specGenSdkArtifactInfo = JSON.parse(result.artifactData);
    const labelActionText = specGenSdkArtifactInfo.labelAction;
    issue_number = parseInt(specGenSdkArtifactInfo.prNumber, 10);
    if (!issue_number) {
      core.warning(
        `No PR number found in the artifact '${artifactName}' with details_url:${details_url}.`,
      );
    }

    /** @type {SdkName} */
    const breakingChangeLanguage = specGenSdkArtifactInfo.language;
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

  if (!labelAction) {
    core.info("No label action found, defaulting to None");
    labelAction = LabelAction.None;
  }

  return { labelName, labelAction, issueNumber: issue_number };
}
