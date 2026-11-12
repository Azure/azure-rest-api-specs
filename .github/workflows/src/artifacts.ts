import type { Core } from "./github.ts";
import { fetchWithRetry } from "./retries.ts";

export type ArtifactResource = {
  downloadUrl?: string;
};

export type ArtifactValue = {
  name: string;
  id?: string;
  resource?: ArtifactResource;
};

export type Artifacts = {
  resource?: ArtifactResource;
};

export type ListArtifactsResponse = {
  value: Array<ArtifactValue>;
};

export async function getAzurePipelineArtifact({
  ado_build_id,
  ado_project_url,
  artifactName,
  artifactFileName,
  core,
  retryOptions = {},
  fallbackToFailedArtifact = false,
  token = undefined,
}: {
  ado_build_id: string;
  ado_project_url: string;
  artifactName: string;
  artifactFileName: string;
  core: Core;
  retryOptions?: import("./retries.ts").RetryOptions;
  fallbackToFailedArtifact?: boolean;
  token?: string;
}): Promise<{ artifactData: string }> {
  const apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`;
  core.info(`Calling Azure DevOps API to get the artifact: ${apiUrl}`);

  const headers = {
    "Content-Type": "application/json",
    ...(token && { Authorization: `Bearer ${token}` }),
  };
  let artifactData = "";
  // Use Node.js fetch with retry to call the API
  let response = await fetchWithRetry(
    apiUrl,
    {
      method: "GET",
      headers,
    },
    retryOptions,
  );

  // If the response is 404, check if we should fallback to the failed artifact
  if (response.status === 404) {
    if (!fallbackToFailedArtifact) {
      core.info(`Artifact '${artifactName}' not found (404)`);
      return { artifactData };
    } else {
      response = await fetchFailedArtifact({
        ado_build_id,
        ado_project_url,
        artifactName,
        core,
        retryOptions,
        headers,
      });
    }
  }

  if (response.ok) {
    // Step 1: Get the download URL for the artifact

    const artifacts: Artifacts = (await response.json()) as Artifacts;
    core.info(`Artifacts found: ${JSON.stringify(artifacts)}`);
    if (!artifacts.resource || !artifacts.resource.downloadUrl) {
      throw new Error(`Download URL not found for the artifact ${artifactName}`);
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
      {
        method: "GET",
        headers,
      },
      retryOptions,
    );
    if (!artifactResponse.ok) {
      throw new Error(`Failed to fetch artifact: ${artifactResponse.statusText}`);
    }

    artifactData = await artifactResponse.text();
  } else {
    core.error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
    const errorText = await response.text();
    core.error(`Error details: ${errorText}`);
  }
  return { artifactData };
}

/**
 * Extracts the ADO build ID and project URL from the given build URL.
 * @throws {Error} If the build URL does not match the expected format.
 */
export function getAdoBuildInfoFromUrl(buildUrl: string): { projectUrl: string; buildId: string } {
  // Extract the ADO build ID and project URL from the check run details URL
  const buildUrlRegex = /^(.*?)(?=\/_build\/).*?[?&]buildId=(\d+)/;
  const match = buildUrl.match(buildUrlRegex);
  if (!match) {
    throw new Error(`Could not extract build ID or project URL from the URL: ${buildUrl}`);
  }
  return { projectUrl: match[1], buildId: match[2] };
}

export async function fetchFailedArtifact({
  ado_build_id,
  ado_project_url,
  artifactName,
  core,
  retryOptions = {},
  headers,
}: {
  ado_build_id: string;
  ado_project_url: string;
  artifactName: string;
  core: Core;
  retryOptions?: import("./retries.ts").RetryOptions;
  headers?: object;
}): Promise<Response> {
  // fallback to fetch the failed artifact
  let apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?api-version=7.0`;
  core.info(`List the artifacts: ${apiUrl}`);
  const response = await fetchWithRetry(
    apiUrl,
    {
      method: "GET",
      headers,
    },
    retryOptions,
  );
  if (!response.ok) {
    throw new Error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
  }

  const listArtifactResponse: ListArtifactsResponse =
    (await response.json()) as ListArtifactsResponse;
  core.info(`Artifacts found: ${JSON.stringify(listArtifactResponse)}`);
  // Use filter to get matching artifacts and sort them in descending alphabetical order
  const artifactsList = listArtifactResponse.value
    .filter((artifact) => artifact.name.includes(artifactName))
    .sort((a, b) => b.name.localeCompare(a.name)); // Descending order (Z to A)
  if (artifactsList.length === 0) {
    const message = `No artifacts found with name containing ${artifactName}`;
    core.warning(message);
    // Return a Response-like object using the global Response constructor
    return new Response(message, {
      status: 404,
      statusText: message,
      headers: { "Content-Type": "text/plain" },
    });
  }
  artifactName = artifactsList[0].name;
  apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`;
  core.info(`Fetching the failed artifact: ${apiUrl}`);
  return await fetchWithRetry(
    apiUrl,
    {
      method: "GET",
      headers,
    },
    retryOptions,
  );
}
