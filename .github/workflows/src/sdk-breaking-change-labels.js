// @ts-check
import { sdkLabels } from "../../src/sdk-types.js";
import { LabelAction } from "./label.js";
import { extractInputs } from "./context.js";
import { getIssueNumber } from "./issues.js";

/**
 * Retry a function with exponential backoff
 * @param {Function} fn - Function to retry
 * @param {Object} options - Retry options
 * @param {number} [options.maxRetries=3] - Maximum number of retries
 * @param {number} [options.initialDelayMs=1000] - Initial delay in milliseconds
 * @param {number} [options.maxDelayMs=10000] - Maximum delay in milliseconds
 * @param {Function} [options.logger] - Logger function
 * @returns {Promise<any>} - Result of the function
 */
async function retry(fn, { maxRetries = 3, initialDelayMs = 1000, maxDelayMs = 10000, logger = console.log } = {}) {
  let lastError;

  for (let attempt = 0; attempt < maxRetries + 1; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;

      if (attempt < maxRetries) {
        const delayMs = Math.min(initialDelayMs * Math.pow(2, attempt), maxDelayMs);
        logger(`Request failed, retrying in ${delayMs}ms... (${attempt + 1}/${maxRetries})`);
        logger(`Error: ${error.message}`);
        await new Promise(resolve => setTimeout(resolve, delayMs));
      }
    }
  }

  throw lastError;
}

/**
 * Fetch with retry functionality
 * @param {string} url - URL to fetch
 * @param {Object} [options] - Fetch options
 * @param {Object} [retryOptions] - Retry options
 * @returns {Promise<Response>} - Fetch response
 */
async function fetchWithRetry(url, options = {}, retryOptions = {}) {
  return retry(
    () => fetch(url, options),
    retryOptions
  );
}

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
 * @returns {Promise<{labelName: string, labelAction: LabelAction, issueNumber: number}>}
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
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api)} params.github
 * @param {typeof import("@actions/core")} params.core
 * @returns {Promise<{labelName: string, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndActionImpl({
  ado_build_id,
  ado_project_url,
  head_sha,
  core,
  github,
}) {
  let issue_number = NaN;
  let labelAction;
  let labelName = "";
  const artifactName = "spec-gen-sdk-breaking-change-artifact";
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
    { logger: core.info }
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
    const artifactResponse = await fetchWithRetry(downloadUrl, {}, { logger: core.info });
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
