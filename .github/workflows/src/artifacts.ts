import type { Core } from "./github.ts";
import { fetchWithRetry } from "./retries.ts";

export type ArtifactResource = {
  downloadUrl?: string;
};

export type ArtifactValue = {
  name: string;
  id?: string;
  source?: string;
  resource?: ArtifactResource;
};

export type Artifacts = {
  resource?: ArtifactResource;
};

export type ListArtifactsResponse = {
  value: Array<ArtifactValue>;
};

type TimelineAttempt = {
  attempt?: number;
  recordId?: string;
};

type TimelineRecord = {
  id?: string;
  type?: string;
  attempt?: number;
  previousAttempts?: TimelineAttempt[];
};

type TimelineResponse = {
  records: TimelineRecord[];
};

export type AzurePipelineArtifactResult = {
  artifactData: string;
};

export type ResolvedAzurePipelineArtifact = {
  artifactName: string;
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

export type AzurePipelineArtifactPairResolution =
  | {
      status: "found";
      artifacts: readonly [ResolvedAzurePipelineArtifact, ResolvedAzurePipelineArtifact];
    }
  | {
      status: "first-only";
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
  maxBytes?: number;
  fetchImpl?: typeof fetch;
};

type ResolveAzurePipelineArtifactOptions = Omit<
  GetAzurePipelineArtifactOptions,
  "artifactFileName" | "maxBytes"
>;

type ResolveAzurePipelineArtifactPairOptions = Omit<
  ResolveAzurePipelineArtifactOptions,
  "artifactName" | "fallbackToFailedArtifact"
> & {
  artifactNames: readonly [string, string];
};

type DownloadAzurePipelineArtifactFileOptions = {
  artifact: ResolvedAzurePipelineArtifact;
  artifactFileName: string;
  retryOptions?: import("./retries.ts").RetryOptions;
  maxBytes?: number;
  fetchImpl?: typeof fetch;
};

type DownloadAzurePipelineArtifactArchiveOptions = {
  artifact: ResolvedAzurePipelineArtifact;
  retryOptions?: import("./retries.ts").RetryOptions;
  maxBytes: number;
  fetchImpl?: typeof fetch;
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
 * Preserves the exact trusted artifact name used as the ZIP prefix. Failed
 * artifacts may differ only by Azure Pipelines' numbered FailedAttempt suffix.
 */
function parseResolvedArtifactName(
  metadata: unknown,
  requestedArtifactName: string,
  allowFailedArtifact: boolean,
): string {
  const resolvedArtifactName =
    metadata && typeof metadata === "object" && "name" in metadata
      ? (metadata as ArtifactValue).name
      : requestedArtifactName;
  const escapedArtifactName = requestedArtifactName.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const failedArtifactPattern = new RegExp(`^${escapedArtifactName}-FailedAttempt\\d+$`);
  if (
    typeof resolvedArtifactName !== "string" ||
    (resolvedArtifactName !== requestedArtifactName &&
      (!allowFailedArtifact || !failedArtifactPattern.test(resolvedArtifactName)))
  ) {
    throw new Error(
      `Unexpected resolved artifact name '${String(resolvedArtifactName)}' for '${requestedArtifactName}'`,
    );
  }
  return resolvedArtifactName;
}

function getArtifactAttempt(
  artifact: ArtifactValue,
  requestedArtifactName: string,
  attemptsBySource: ReadonlyMap<string, number>,
): number | undefined {
  if (artifact.name === requestedArtifactName) {
    if (!artifact.source) {
      throw new Error(`Artifact '${requestedArtifactName}' is missing its source job`);
    }
    const attempt = attemptsBySource.get(artifact.source);
    if (attempt === undefined) {
      throw new Error(
        `Artifact '${requestedArtifactName}' source job '${artifact.source}' is missing from the build timeline`,
      );
    }
    return attempt;
  }
  const escapedArtifactName = requestedArtifactName.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = artifact.name.match(
    new RegExp(`^${escapedArtifactName}-FailedAttempt([1-9]\\d*)$`),
  );
  if (!match) {
    return undefined;
  }
  const attempt = Number.parseInt(match[1], 10);
  return Number.isSafeInteger(attempt) ? attempt : undefined;
}

function indexArtifactsByAttempt(
  artifacts: ArtifactValue[],
  requestedArtifactName: string,
  attemptsBySource: ReadonlyMap<string, number>,
): Map<number, ArtifactValue> {
  const artifactsByAttempt = new Map<number, ArtifactValue>();
  for (const artifact of artifacts) {
    const attempt = getArtifactAttempt(artifact, requestedArtifactName, attemptsBySource);
    if (attempt === undefined) {
      continue;
    }
    if (artifactsByAttempt.has(attempt)) {
      throw new Error(
        `Multiple artifacts resolve to '${requestedArtifactName}' attempt ${attempt}`,
      );
    }
    artifactsByAttempt.set(attempt, artifact);
  }
  return artifactsByAttempt;
}

function selectPreferredAttempt(attempts: number[]): number | undefined {
  return attempts.sort((left, right) => right - left)[0];
}

async function getArtifactSourceAttempts(
  adoBuildId: string,
  adoProjectUrl: string,
  retryOptions: import("./retries.ts").RetryOptions,
  headers: Record<string, string>,
  fetchImpl: typeof fetch,
): Promise<Map<string, number>> {
  const response = await fetchWithRetry(
    `${adoProjectUrl}/_apis/build/builds/${adoBuildId}/timeline?api-version=7.0`,
    {
      method: "GET",
      headers,
    },
    retryOptions,
    fetchImpl,
  );
  if (!response.ok) {
    throw new Error(`Failed to fetch build timeline: ${response.status}, ${response.statusText}`);
  }

  const metadata: unknown = await response.json();
  if (
    !metadata ||
    typeof metadata !== "object" ||
    !("records" in metadata) ||
    !Array.isArray((metadata as TimelineResponse).records)
  ) {
    throw new Error("Malformed Azure Pipelines build timeline");
  }

  const attemptsBySource = new Map<string, number>();
  for (const record of (metadata as TimelineResponse).records) {
    if (record.type !== "Job") {
      continue;
    }
    if (
      typeof record.id === "string" &&
      Number.isSafeInteger(record.attempt) &&
      Number(record.attempt) > 0
    ) {
      attemptsBySource.set(record.id, Number(record.attempt));
    }
    for (const previousAttempt of record.previousAttempts ?? []) {
      if (
        typeof previousAttempt.recordId === "string" &&
        Number.isSafeInteger(previousAttempt.attempt) &&
        Number(previousAttempt.attempt) > 0
      ) {
        attemptsBySource.set(previousAttempt.recordId, Number(previousAttempt.attempt));
      }
    }
  }
  return attemptsBySource;
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
  fetchImpl = fetch,
}: ResolveAzurePipelineArtifactOptions): Promise<AzurePipelineArtifactResolution> {
  const headers = getArtifactHeaders(token);
  let response = await fetchWithRetry(
    `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`,
    {
      method: "GET",
      headers,
    },
    retryOptions,
    fetchImpl,
  );

  if (response.status === 404 && fallbackToFailedArtifact) {
    response = await fetchFailedArtifact({
      ado_build_id,
      ado_project_url,
      artifactName,
      core,
      retryOptions,
      headers,
      fetchImpl,
    });
  }

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
      artifactName: parseResolvedArtifactName(metadata, artifactName, fallbackToFailedArtifact),
      downloadUrl: parseArtifactDownloadUrl(metadata, artifactName),
      headers,
    },
  };
}

/**
 * Resolves the newest attempt that contains both requested artifacts.
 */
export async function resolveAzurePipelineArtifactPair({
  ado_build_id,
  ado_project_url,
  artifactNames,
  core,
  retryOptions = {},
  token = undefined,
  fetchImpl = fetch,
}: ResolveAzurePipelineArtifactPairOptions): Promise<AzurePipelineArtifactPairResolution> {
  const headers = getArtifactHeaders(token);
  const response = await fetchWithRetry(
    `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?api-version=7.0`,
    {
      method: "GET",
      headers,
    },
    retryOptions,
    fetchImpl,
  );
  if (!response.ok) {
    throw new Error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
  }

  const metadata: unknown = await response.json();
  if (
    !metadata ||
    typeof metadata !== "object" ||
    !("value" in metadata) ||
    !Array.isArray((metadata as ListArtifactsResponse).value)
  ) {
    throw new Error("Malformed Azure Pipelines artifact list");
  }
  const artifacts = (metadata as ListArtifactsResponse).value;
  core.info(`Artifacts found: ${JSON.stringify(metadata)}`);

  const [firstArtifactName, secondArtifactName] = artifactNames;
  const exactArtifacts = artifacts.filter(
    (artifact) => artifact.name === firstArtifactName || artifact.name === secondArtifactName,
  );
  const escapedArtifactNames = artifactNames.map((name) =>
    name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"),
  );
  const hasFailedArtifacts = artifacts.some((artifact) =>
    escapedArtifactNames.some((name) =>
      new RegExp(`^${name}-FailedAttempt[1-9]\\d*$`).test(artifact.name),
    ),
  );
  const attemptsBySource =
    exactArtifacts.length === 0
      ? new Map<string, number>()
      : hasFailedArtifacts
        ? await getArtifactSourceAttempts(
            ado_build_id,
            ado_project_url,
            retryOptions,
            headers,
            fetchImpl,
          )
        : new Map(
            exactArtifacts
              .filter(
                (artifact): artifact is ArtifactValue & { source: string } =>
                  typeof artifact.source === "string",
              )
              .map((artifact) => [artifact.source, 1]),
          );
  const firstArtifactsByAttempt = indexArtifactsByAttempt(
    artifacts,
    firstArtifactName,
    attemptsBySource,
  );
  const secondArtifactsByAttempt = indexArtifactsByAttempt(
    artifacts,
    secondArtifactName,
    attemptsBySource,
  );
  const selectedAttempt = selectPreferredAttempt([...firstArtifactsByAttempt.keys()]);

  const resolveArtifact = (
    artifact: ArtifactValue | undefined,
    requestedArtifactName: string,
  ): ResolvedAzurePipelineArtifact => {
    if (!artifact) {
      throw new Error(`Artifact '${requestedArtifactName}' disappeared during pair resolution`);
    }
    return {
      artifactName: artifact.name,
      downloadUrl: parseArtifactDownloadUrl(artifact, requestedArtifactName),
      headers,
    };
  };

  if (selectedAttempt === undefined) {
    core.info(`No '${firstArtifactName}' artifact found`);
    return { status: "not-found" };
  }

  const firstArtifact = resolveArtifact(
    firstArtifactsByAttempt.get(selectedAttempt),
    firstArtifactName,
  );
  const secondArtifact = secondArtifactsByAttempt.get(selectedAttempt);
  if (!secondArtifact) {
    core.info(
      `No matching artifact attempt contains both '${firstArtifactName}' and '${secondArtifactName}'`,
    );
    return {
      status: "first-only",
      artifact: firstArtifact,
    };
  }

  return {
    status: "found",
    artifacts: [firstArtifact, resolveArtifact(secondArtifact, secondArtifactName)],
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
  fetchImpl = fetch,
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
    fetchImpl,
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
  fetchImpl = fetch,
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
    fetchImpl,
  );
  if (!artifactResponse.ok) {
    throw new Error(
      `Failed to fetch artifact archive: ${artifactResponse.status}, ${artifactResponse.statusText}`,
    );
  }
  return await readResponseBytesWithLimit(artifactResponse, maxBytes);
}

export async function getAzurePipelineArtifact({
  ado_build_id,
  ado_project_url,
  artifactName,
  artifactFileName,
  core,
  retryOptions = {},
  fallbackToFailedArtifact = false,
  token = undefined,
  maxBytes,
  fetchImpl = fetch,
}: GetAzurePipelineArtifactOptions): Promise<AzurePipelineArtifactResult> {
  try {
    const resolution = await resolveAzurePipelineArtifact({
      ado_build_id,
      ado_project_url,
      artifactName,
      core,
      retryOptions,
      fallbackToFailedArtifact,
      token,
      fetchImpl,
    });
    if (resolution.status === "not-found") {
      return { artifactData: "" };
    }

    const artifactData = await downloadAzurePipelineArtifactFile({
      artifact: resolution.artifact,
      artifactFileName,
      retryOptions,
      maxBytes,
      fetchImpl,
    });
    return { artifactData };
  } catch (error) {
    if (error instanceof AzurePipelineArtifactHttpError) {
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
  fetchImpl = fetch,
}: {
  ado_build_id: string;
  ado_project_url: string;
  artifactName: string;
  core: Core;
  retryOptions?: import("./retries.ts").RetryOptions;
  headers?: object;
  fetchImpl?: typeof fetch;
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
    fetchImpl,
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
  const selectedArtifactUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${selectedArtifact.name}&api-version=7.0`;
  core.info(`Fetching the failed artifact: ${selectedArtifactUrl}`);
  return await fetchWithRetry(
    selectedArtifactUrl,
    {
      method: "GET",
      headers,
    },
    retryOptions,
    fetchImpl,
  );
}
