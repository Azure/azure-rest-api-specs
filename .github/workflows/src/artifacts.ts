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

export type AzurePipelineArtifactResult = {
  artifactData: string;
};

export type StrictAzurePipelineArtifactResult =
  | {
      status: "found";
      artifactData: string;
    }
  | {
      status: "not-found";
      artifactData: "";
    };

export type ResolvedAzurePipelineArtifact = {
  downloadUrl: string;
  headers: Record<string, string>;
};

export type AzurePipelineArtifactResolution =
  | {
      status: "found";
      artifact: ResolvedAzurePipelineArtifact;
    }
  | {
      status: "not-found";
    };

type GetAzurePipelineArtifactOptions = {
  ado_build_id: string;
  ado_project_url: string;
  artifactName: string;
  artifactFileName: string;
  core: Core;
  retryOptions?: import("./retries.ts").RetryOptions;
  fallbackToFailedArtifact?: boolean;
  token?: string;
  strict?: boolean;
  maxBytes?: number;
};

type ResolveAzurePipelineArtifactOptions = Omit<
  GetAzurePipelineArtifactOptions,
  "artifactFileName" | "strict" | "maxBytes"
>;

type DownloadAzurePipelineArtifactFileOptions = {
  artifact: ResolvedAzurePipelineArtifact;
  artifactFileName: string;
  retryOptions?: import("./retries.ts").RetryOptions;
  maxBytes?: number;
};

type DownloadAzurePipelineArtifactArchiveOptions = {
  artifact: ResolvedAzurePipelineArtifact;
  retryOptions?: import("./retries.ts").RetryOptions;
  maxBytes: number;
};

type ByteStreamReadResult = { done: true; value?: undefined } | { done: false; value: Uint8Array };

class AzurePipelineArtifactHttpError extends Error {
  public readonly status: number;

  public constructor(message: string, status: number) {
    super(message);
    this.status = status;
  }
}

async function readResponseTextWithLimit(response: Response, maxBytes?: number): Promise<string> {
  return new TextDecoder().decode(await readResponseBytesWithLimit(response, maxBytes));
}

async function readResponseBytesWithLimit(
  response: Response,
  maxBytes?: number,
): Promise<Uint8Array> {
  const contentLength = response.headers?.get("content-length");
  if (contentLength) {
    const parsedContentLength = Number(contentLength);
    if (!Number.isSafeInteger(parsedContentLength) || parsedContentLength < 0) {
      throw new Error(`Artifact response has invalid Content-Length '${contentLength}'`);
    }
    if (maxBytes !== undefined && parsedContentLength > maxBytes) {
      throw new Error(`Artifact content exceeds ${maxBytes} bytes`);
    }
  }

  if (maxBytes !== undefined && response.body) {
    const reader = response.body.getReader();
    const chunks: Uint8Array[] = [];
    let totalBytes = 0;
    while (true) {
      const readResult = (await reader.read()) as ByteStreamReadResult;
      if (readResult.done) {
        break;
      }
      const { value } = readResult;
      totalBytes += value.byteLength;
      if (totalBytes > maxBytes) {
        await reader.cancel();
        throw new Error(`Artifact content exceeds ${maxBytes} bytes`);
      }
      chunks.push(value);
    }
    const bytes = new Uint8Array(totalBytes);
    let offset = 0;
    for (const chunk of chunks) {
      bytes.set(chunk, offset);
      offset += chunk.byteLength;
    }
    return bytes;
  }

  const bytes =
    typeof response.arrayBuffer === "function"
      ? new Uint8Array(await response.arrayBuffer())
      : new TextEncoder().encode(await response.text());
  if (maxBytes !== undefined && bytes.byteLength > maxBytes) {
    throw new Error(`Artifact content exceeds ${maxBytes} bytes`);
  }
  return bytes;
}

function getArtifactHeaders(token?: string): Record<string, string> {
  return {
    "Content-Type": "application/json",
    ...(token && { Authorization: `Bearer ${token}` }),
  };
}

function parseArtifactDownloadUrl(metadata: unknown, artifactName: string): string {
  if (!metadata || typeof metadata !== "object") {
    throw new Error(`Malformed metadata for artifact ${artifactName}`);
  }

  const resource = (metadata as Artifacts).resource;
  if (!resource || typeof resource.downloadUrl !== "string" || !resource.downloadUrl) {
    throw new Error(`Download URL not found for the artifact ${artifactName}`);
  }

  let parsedUrl: URL;
  try {
    parsedUrl = new URL(resource.downloadUrl);
  } catch (error) {
    throw new Error(`Invalid download URL for the artifact ${artifactName}`, { cause: error });
  }
  if (parsedUrl.protocol !== "https:") {
    throw new Error(`Invalid download URL protocol for the artifact ${artifactName}`);
  }

  parsedUrl.searchParams.delete("format");
  return parsedUrl.toString();
}

/**
 * Resolves Azure Pipelines artifact metadata once into a reusable download target.
 * Only a verified 404 is returned as not found. Authentication, throttling, server,
 * network, and malformed-metadata failures are thrown.
 */
export async function resolveAzurePipelineArtifact({
  ado_build_id,
  ado_project_url,
  artifactName,
  core,
  retryOptions = {},
  fallbackToFailedArtifact = false,
  token = undefined,
}: ResolveAzurePipelineArtifactOptions): Promise<AzurePipelineArtifactResolution> {
  const headers = getArtifactHeaders(token);
  const response = fallbackToFailedArtifact
    ? await fetchFailedArtifact({
        ado_build_id,
        ado_project_url,
        artifactName,
        core,
        retryOptions,
        headers,
      })
    : await fetchWithRetry(
        `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`,
        {
          method: "GET",
          headers,
        },
        retryOptions,
      );

  if (response.status === 404) {
    core.info(`Artifact '${artifactName}' not found (404)`);
    return { status: "not-found" };
  }
  if (!response.ok) {
    core.error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
    const errorText = await response.text();
    core.error(`Error details: ${errorText}`);
    throw new AzurePipelineArtifactHttpError(
      `Failed to fetch artifact '${artifactName}': ${response.status}, ${response.statusText}`,
      response.status,
    );
  }

  const metadata: unknown = await response.json();
  core.info(`Artifacts found: ${JSON.stringify(metadata)}`);
  return {
    status: "found",
    artifact: {
      downloadUrl: parseArtifactDownloadUrl(metadata, artifactName),
      headers,
    },
  };
}

/**
 * Downloads one bounded file from a previously resolved Azure Pipelines artifact.
 */
export async function downloadAzurePipelineArtifactFile({
  artifact,
  artifactFileName,
  retryOptions = {},
  maxBytes,
}: DownloadAzurePipelineArtifactFileOptions): Promise<string> {
  const separator = artifact.downloadUrl.includes("?") ? "&" : "?";
  const url = `${artifact.downloadUrl}${separator}format=file&subPath=/${artifactFileName}`;
  const artifactResponse = await fetchWithRetry(
    url,
    {
      method: "GET",
      headers: artifact.headers,
    },
    retryOptions,
  );
  if (!artifactResponse.ok) {
    throw new Error(
      `Failed to fetch artifact file '${artifactFileName}': ${artifactResponse.status}, ${artifactResponse.statusText}`,
    );
  }

  return await readResponseTextWithLimit(artifactResponse, maxBytes);
}

/**
 * Downloads one bounded ZIP archive from a previously resolved Azure Pipelines artifact.
 */
export async function downloadAzurePipelineArtifactArchive({
  artifact,
  retryOptions = {},
  maxBytes,
}: DownloadAzurePipelineArtifactArchiveOptions): Promise<Uint8Array> {
  const parsedUrl = new URL(artifact.downloadUrl);
  parsedUrl.searchParams.set("format", "zip");
  parsedUrl.searchParams.delete("subPath");
  const artifactResponse = await fetchWithRetry(
    parsedUrl.toString(),
    {
      method: "GET",
      headers: artifact.headers,
    },
    retryOptions,
  );
  if (!artifactResponse.ok) {
    throw new Error(
      `Failed to fetch artifact archive: ${artifactResponse.status}, ${artifactResponse.statusText}`,
    );
  }
  return await readResponseBytesWithLimit(artifactResponse, maxBytes);
}

export function getAzurePipelineArtifact(
  options: GetAzurePipelineArtifactOptions & { strict: true },
): Promise<StrictAzurePipelineArtifactResult>;
export function getAzurePipelineArtifact(
  options: GetAzurePipelineArtifactOptions & { strict?: false },
): Promise<AzurePipelineArtifactResult>;
export async function getAzurePipelineArtifact({
  ado_build_id,
  ado_project_url,
  artifactName,
  artifactFileName,
  core,
  retryOptions = {},
  fallbackToFailedArtifact = false,
  token = undefined,
  strict = false,
  maxBytes,
}: GetAzurePipelineArtifactOptions): Promise<
  AzurePipelineArtifactResult | StrictAzurePipelineArtifactResult
> {
  try {
    const resolution = await resolveAzurePipelineArtifact({
      ado_build_id,
      ado_project_url,
      artifactName,
      core,
      retryOptions,
      fallbackToFailedArtifact,
      token,
    });
    if (resolution.status === "not-found") {
      return strict ? { status: "not-found", artifactData: "" } : { artifactData: "" };
    }

    const artifactData = await downloadAzurePipelineArtifactFile({
      artifact: resolution.artifact,
      artifactFileName,
      retryOptions,
      maxBytes,
    });
    return strict ? { status: "found", artifactData } : { artifactData };
  } catch (error) {
    if (!strict && error instanceof AzurePipelineArtifactHttpError) {
      return { artifactData: "" };
    }
    throw error;
  }
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

/**
 * Resolves an exact or latest matching failed artifact from one list-artifacts request.
 */
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
  const apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?api-version=7.0`;
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
  const selectedArtifact =
    listArtifactResponse.value.find((artifact) => artifact.name === artifactName) ??
    listArtifactResponse.value
      .filter((artifact) => artifact.name.includes(artifactName))
      .sort((a, b) => b.name.localeCompare(a.name))[0];
  if (!selectedArtifact) {
    const message = `No artifacts found with name containing ${artifactName}`;
    core.warning(message);
    // Return a Response-like object using the global Response constructor
    return new Response(message, {
      status: 404,
      statusText: message,
      headers: { "Content-Type": "text/plain" },
    });
  }
  return new Response(JSON.stringify(selectedArtifact), {
    status: 200,
    headers: { "Content-Type": "application/json" },
  });
}
