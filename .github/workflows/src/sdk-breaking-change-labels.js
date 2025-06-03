// @ts-check
import { sdkLabels } from "../../shared/src/sdk-types.js";
import { extractInputs } from "./context.js";
import { getIssueNumber } from "./issues.js";
import { LabelAction } from "./label.js";
import { fetchWithRetry } from "./retries.js";

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
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{labelName: string | undefined, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndAction({ github, context, core }) {
  const inputs = await extractInputs(github, context, core);
  const ado_build_id = inputs.ado_build_id;
  const ado_project_url = inputs.ado_project_url;
  const head_sha = inputs.head_sha;
  if (!ado_build_id || !ado_project_url || !head_sha) {
    throw new Error(
      `Required inputs are not valid: ado_build_id:${ado_build_id}, ado_project_url:${ado_project_url}, head_sha:${head_sha}`,
    );
  }
  return await getLabelAndActionImpl({
    ado_build_id,
    ado_project_url,
    head_sha,
    core,
    github,
  });
}

/**
 * @param {Object} params
 * @param {string} params.ado_build_id
 * @param {string} params.ado_project_url
 * @param {string} params.head_sha
 * @param {typeof import("@actions/core")} params.core
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api)} params.github
 * @param {import('./retries.js').RetryOptions} [params.retryOptions]
 * @returns {Promise<{labelName: string | undefined, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndActionImpl({
  ado_build_id,
  ado_project_url,
  head_sha,
  core,
  github,
  retryOptions = {},
}) {
  // Override default logger from console.log to core.info
  retryOptions = { logger: core.info, ...retryOptions };

  let issue_number = NaN;
  let labelAction;
  /** @type {String | undefined} */
  let labelName = "";
  const artifactName = "spec-gen-sdk-artifact";
  const artifactFileName = artifactName + ".json";
  const apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`;
  core.info(`Calling Azure DevOps API to get the artifact: ${apiUrl}`);

  // Use Node.js fetch with retry to call the API
  const response = await fetchWithRetry(
    apiUrl,
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    },
    retryOptions,
  );

  if (response.status === 404) {
    core.info(
      `Artifact '${artifactName}' not found (404). This might be expected if there are no breaking changes.`,
    );
  } else if (response.ok) {
    // Step 1: Get the download URL for the artifact
    /** @type {Artifacts} */
    const artifacts = /** @type {Artifacts} */ (await response.json());
    core.info(`Artifacts found: ${JSON.stringify(artifacts)}`);
    if (!artifacts.resource || !artifacts.resource.downloadUrl) {
      throw new Error(
        `Download URL not found for the artifact ${artifactName}`,
      );
    }

    let downloadUrl = artifacts.resource.downloadUrl;
    const index = downloadUrl.indexOf("?format=zip");
    if (index !== -1) {
      // Keep everything up to (but not including) "?format=zip"
      downloadUrl = downloadUrl.substring(0, index);
    }
    downloadUrl += `?format=file&subPath=/${artifactFileName}`;
    core.info(`Downloading artifact from: ${downloadUrl}`);

    // Step 2: Fetch Artifact Content (as a Buffer) with retry
    const artifactResponse = await fetchWithRetry(
      downloadUrl,
      {},
      { logger: core.info },
    );
    if (!artifactResponse.ok) {
      throw new Error(
        `Failed to fetch artifact: ${artifactResponse.statusText}`,
      );
    }

    const artifactData = await artifactResponse.text();
    core.info(`Artifact content: ${artifactData}`);

    // Parse the JSON data
    const breakingChangeResult = JSON.parse(artifactData);
    const labelActionText = breakingChangeResult.labelAction;
    /** @type {SdkName} */
    const breakingChangeLanguage = breakingChangeResult.language;
    if (breakingChangeLanguage) {
      labelName = sdkLabels[`${breakingChangeLanguage}`].breakingChange;
    }

    // Set label action and name based on the artifacts
    if (labelActionText === true) {
      labelAction = LabelAction.Add;
    } else if (labelActionText === false) {
      labelAction = LabelAction.Remove;
    }

    // Get the issue number from the check run
    if (!issue_number) {
      const { issueNumber } = await getIssueNumber({ head_sha, core, github });
      issue_number = issueNumber;
    }
  } else {
    core.error(
      `Failed to fetch artifacts: ${response.status}, ${response.statusText}`,
    );
    const errorText = await response.text();
    core.error(`Error details: ${errorText}`);
  }
  if (!labelAction) {
    core.info("No label action found, defaulting to None");
    labelAction = LabelAction.None;
  }

  return { labelName, labelAction, issueNumber: issue_number };
}
