import fs from "node:fs";
import path from "node:path";

import { SdkChangeSchema } from "../../shared/src/sdk-types.js";
import { getAdoBuildInfoFromUrl, getAzurePipelineArtifact } from "./artifacts.js";

const ARTIFACT_NAME = "spec-gen-sdk-artifact";

/**
 * Read SDK changes from a spec-gen-sdk Azure Pipeline artifact.
 *
 * @param {Object} params
 * @param {string} params.detailsUrl
 * @param {typeof import('@actions/core')} params.core
 * @param {import('./retries.js').RetryOptions} [params.retryOptions]
 * @returns {Promise<unknown>}
 */
export async function readSdkChangesFromPipelineArtifact({
  detailsUrl,
  core,
  retryOptions = {},
}) {
  const { projectUrl, buildId } = getAdoBuildInfoFromUrl(detailsUrl);
  const { artifactData } = await getAzurePipelineArtifact({
    ado_build_id: buildId,
    ado_project_url: projectUrl,
    artifactName: ARTIFACT_NAME,
    artifactFileName: `${ARTIFACT_NAME}.json`,
    core,
    retryOptions: { logger: core.info, ...retryOptions },
    fallbackToFailedArtifact: true,
    token: process.env.ADO_TOKEN,
  });

  if (!artifactData) {
    throw new Error(`Artifact '${ARTIFACT_NAME}' was not found or could not be downloaded.`);
  }

  return SdkChangeSchema.parse(JSON.parse(artifactData));
}

/**
 * Download SDK changes from a spec-gen-sdk Azure Pipeline artifact to a file.
 *
 * @param {Object} params
 * @param {string} params.detailsUrl
 * @param {string} params.destinationPath
 * @param {typeof import('@actions/core')} params.core
 * @param {import('./retries.js').RetryOptions} [params.retryOptions]
 * @returns {Promise<string>} The destination path.
 */
export async function downloadSdkChangesFromPipelineArtifact({
  detailsUrl,
  destinationPath,
  core,
  retryOptions = {},
}) {
  const sdkChanges = await readSdkChangesFromPipelineArtifact({
    detailsUrl,
    core,
    retryOptions,
  });
  fs.mkdirSync(path.dirname(destinationPath), { recursive: true });
  fs.writeFileSync(destinationPath, JSON.stringify(sdkChanges, undefined, 2));
  return destinationPath;
}