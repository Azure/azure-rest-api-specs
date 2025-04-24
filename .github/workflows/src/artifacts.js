// @ts-check
import { fetchWithRetry } from "./retries.js";

/**
 * @typedef {Object} ArtifactResource
 * @property {string} [downloadUrl]
 */

/**
 * @typedef {Object} Artifacts
 * @property {ArtifactResource} [resource]
 */

/**
 * @param {Object} params
 * @param {string} params.ado_build_id
 * @param {string} params.ado_project_url
 * @param {string} params.artifactName
 * @param {string} params.artifactFileName
 * @param {typeof import("@actions/core")} params.core
 * @param {import('./retries.js').RetryOptions} [params.retryOptions]
 * @returns {Promise<{artifactData: string}>}
 */
export async function getAzurePipelineArtifact({
  ado_build_id,
  ado_project_url,
  artifactName,
  artifactFileName,
  core,
  retryOptions = {},
}) {
  const apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`;
  core.info(`Calling Azure DevOps API to get the artifact: ${apiUrl}`);

  let artifactData = "";
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
    core.info(`Artifact '${artifactName}' not found (404)`);
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

    artifactData = await artifactResponse.text();
  } else {
    core.error(
      `Failed to fetch artifacts: ${response.status}, ${response.statusText}`,
    );
    const errorText = await response.text();
    core.error(`Error details: ${errorText}`);
  }
  return { artifactData };
}

/**
 * Extracts the ADO build ID and project URL from the given build URL.
 * @param {string} buildUrl
 * @returns {{projectUrl: string, buildId: string}}
 * @throws {Error} If the build URL does not match the expected format.
 */
export function getAdoBuildInfoFromUrl(buildUrl) {
  // Extract the ADO build ID and project URL from the check run details URL
  const buildUrlRegex = /^(.*?)(?=\/_build\/).*?[?&]buildId=(\d+)/;
  const match = buildUrl.match(buildUrlRegex);
  if (!match) {
    throw new Error(
      `Could not extract build ID or project URL from the URL: ${buildUrl}`,
    );
  }
  return { projectUrl: match[1], buildId: match[2] };
}
