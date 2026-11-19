import { SpecGenSdkArtifactInfoSchema } from "@azure-tools/specs-shared/sdk-types";
import * as z from "zod";
import { downloadAzurePipelineArtifactFile } from "../../../../.github/workflows/src/artifacts.ts";

const repository = "Azure/azure-rest-api-specs-pr";
const positiveId = z.number().int().positive().safe();
const guid = z.string().uuid();
const timestamp = z.iso.datetime({ offset: true });
const sha = z.string().regex(/^[a-f0-9]{40}$/i);
const MAX_TEXT_BYTES = 65_535;
const MAX_MANIFEST_BYTES = 1024 * 1024;

const buildSchema = z.object({
  id: positiveId,
  definition: z.object({ id: positiveId }),
  project: z.object({ id: guid, name: z.literal("internal") }),
  repository: z.object({ type: z.literal("GitHub"), name: z.literal(repository) }),
  reason: z.literal("pullRequest"),
  status: z.literal("completed"),
  triggerInfo: z.object({ "pr.sourceSha": sha, "pr.number": z.string().regex(/^[1-9]\d*$/) }),
});

const timelineSchema = z.object({
  records: z.array(
    z.object({
      id: guid,
      parentId: guid.nullish(),
      type: z.string(),
      identifier: z.string().nullish(),
      attempt: positiveId.nullish(),
      state: z.string(),
      finishTime: timestamp.nullable().optional(),
    }),
  ),
});

const checkSchema = z.object({
  id: positiveId,
  name: z.string(),
  head_sha: sha,
  external_id: z.string().nullable(),
  details_url: z.string().nullable(),
  status: z.string(),
  conclusion: z.string().nullable(),
  started_at: timestamp.nullable(),
  completed_at: timestamp.nullable(),
  app: z.object({ id: positiveId, slug: z.string() }),
  output: z.object({
    title: z.string().nullable().optional(),
    summary: z.string().nullable().optional(),
    text: z.string().nullable().optional(),
  }),
});
type Check = z.infer<typeof checkSchema>;

export interface PublisherOptions {
  collectionUri: string;
  projectId: string;
  buildId: number;
  allowedDefinitionIds: number[];
  publisherAppId: number;
  adoToken: string;
  githubToken: string;
  fetchImpl?: typeof fetch;
}

function assertCollectionUri(value: string): string {
  const url = new URL(value);
  if (
    url.protocol !== "https:" ||
    url.hostname !== "dev.azure.com" ||
    !/^\/[a-zA-Z0-9-]+\/$/.test(url.pathname) ||
    url.port ||
    url.username ||
    url.password ||
    url.search ||
    url.hash
  ) {
    throw new Error(
      "Expected an Azure DevOps collection URI https://dev.azure.com/<organization>/",
    );
  }
  return url.href;
}

function matchesBuildUrl(
  value: string | null,
  collectionUri: string,
  projectId: string,
  buildId: number,
): boolean {
  if (!value) return false;
  const expected = new URL(`${collectionUri}${projectId}/_build/results`);
  const actual = new URL(value);
  return (
    actual.origin === expected.origin &&
    [
      expected.pathname.toLowerCase(),
      `${new URL(collectionUri).pathname}internal/_build/results`.toLowerCase(),
    ].includes(actual.pathname.toLowerCase()) &&
    actual.searchParams.get("buildId") === String(buildId) &&
    !actual.username &&
    !actual.password &&
    !actual.hash
  );
}

/** Validates the original object without projecting away any present or future manifest fields. */
export function encodeMetadata(
  manifest: string,
  build: {
    collectionUri: string;
    projectId: string;
    definitionId: number;
    buildId: number;
    stageAttempt: number;
    jobAttempt: number;
    jobId: string;
  },
  sourceCheck: { id: number; name: string; startedAt: string; completedAt: string },
  expectedHeadSha: string,
  expectedPrNumber: string,
): string {
  const artifact: unknown = JSON.parse(manifest);
  const validated = SpecGenSdkArtifactInfoSchema.parse(artifact);
  if (validated.headSha !== expectedHeadSha || validated.prNumber !== expectedPrNumber) {
    throw new Error("Manifest does not belong to the source build PR/head");
  }
  const text = JSON.stringify({
    schemaVersion: 1,
    kind: "spec-gen-sdk-metadata",
    build,
    sourceCheck,
    artifact,
  });
  if (Buffer.byteLength(text, "utf8") > MAX_TEXT_BYTES) {
    throw new Error("SDK metadata exceeds the 65,535-byte check output.text limit");
  }
  return text;
}

export async function publishSdkMetadata(
  options: PublisherOptions,
): Promise<"created" | "unchanged"> {
  const collectionUri = assertCollectionUri(options.collectionUri);
  const projectId = guid.parse(options.projectId);
  const buildId = positiveId.parse(options.buildId);
  const publisherAppId = positiveId.parse(options.publisherAppId);
  if (publisherAppId === 1086291 || publisherAppId === 9426) {
    throw new Error(
      "A dedicated metadata writer App is required, not the source reader or Azure Pipelines App",
    );
  }
  const allowedDefinitionIds = z.array(positiveId).nonempty().parse(options.allowedDefinitionIds);
  if (!options.adoToken || !options.githubToken)
    throw new Error("Both publisher credentials are required");
  const fetchImpl = options.fetchImpl ?? fetch;
  const buildApi = `${collectionUri}${projectId}/_apis/build/builds/${buildId}`;
  const githubApi = `https://api.github.com/repos/${repository}`;
  const adoHeaders = { Authorization: `Bearer ${options.adoToken}` };
  const githubHeaders = {
    Authorization: `Bearer ${options.githubToken}`,
    Accept: "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
    "Content-Type": "application/json",
  };
  async function get(url: string, headers: Record<string, string>): Promise<unknown> {
    const response = await fetchImpl(url, { headers, signal: AbortSignal.timeout(30_000) });
    if (!response.ok) throw new Error(`Metadata API read failed (${response.status})`);
    return response.json();
  }
  async function listChecks(headSha: string): Promise<Check[]> {
    const checks: Check[] = [];
    for (let page = 1; ; page++) {
      const response = z
        .object({ check_runs: z.array(checkSchema) })
        .parse(
          await get(
            `${githubApi}/commits/${headSha}/check-runs?filter=all&per_page=100&page=${page}`,
            githubHeaders,
          ),
        );
      checks.push(...response.check_runs);
      if (response.check_runs.length < 100) return checks;
    }
  }

  const installation = z
    .object({
      total_count: z.literal(1),
      repositories: z.array(z.object({ full_name: z.literal(repository) })).length(1),
    })
    .safeParse(await get("https://api.github.com/installation/repositories", githubHeaders));
  if (!installation.success) {
    throw new Error("Writer installation token must be restricted to the private specs repository");
  }
  const build = buildSchema.parse(await get(`${buildApi}?api-version=7.1`, adoHeaders));
  if (
    build.id !== buildId ||
    build.project.id.toLowerCase() !== projectId.toLowerCase() ||
    !allowedDefinitionIds.includes(build.definition.id)
  ) {
    throw new Error("Source build is not an allowlisted private PR validation build");
  }
  const timeline = timelineSchema.parse(
    await get(`${buildApi}/timeline?api-version=7.1`, adoHeaders),
  );
  const stages = timeline.records.filter(
    (record) => record.type === "Stage" && record.identifier === "Build",
  );
  const stage = stages.length === 1 ? stages[0] : undefined;
  const jobs = timeline.records.filter(
    (record) => record.type === "Job" && record.parentId === stage?.id,
  );
  const job = jobs.length === 1 ? jobs[0] : undefined;
  if (
    stage?.state !== "completed" ||
    job?.state !== "completed" ||
    !stage.attempt ||
    !job.attempt ||
    !job.finishTime
  ) {
    throw new Error("Cannot identify one completed SDK generation stage/job attempt");
  }
  const headSha = build.triggerInfo["pr.sourceSha"];
  const nativeExternalId = `${build.definition.id}|${buildId}|${projectId}`;
  const checks = await listChecks(headSha);
  const native = checks
    .filter(
      (check) =>
        check.app.id === 9426 &&
        check.app.slug === "azure-pipelines" &&
        check.external_id?.toLowerCase() === nativeExternalId.toLowerCase() &&
        check.head_sha === headSha &&
        matchesBuildUrl(check.details_url, collectionUri, projectId, buildId),
    )
    .sort((a, b) => b.id - a.id)[0];
  if (
    native?.status !== "completed" ||
    !native.started_at ||
    !native.completed_at ||
    Date.parse(native.completed_at) < Date.parse(job.finishTime)
  ) {
    throw new Error(
      "No current completed native pipeline check; retry publication after it completes",
    );
  }
  const identity = {
    collectionUri,
    projectId,
    definitionId: build.definition.id,
    buildId,
    stageAttempt: stage.attempt,
    jobAttempt: job.attempt,
    jobId: job.id,
  };
  const sourceCheck = {
    id: native.id,
    name: native.name,
    startedAt: native.started_at,
    completedAt: native.completed_at,
  };
  const externalId = `spec-gen-sdk-metadata:v1:${projectId}:${build.definition.id}:${buildId}:${stage.attempt}:${job.attempt}`;
  const name = `SDK metadata / ${build.definition.id}`;
  const detailsUrl = native.details_url;

  let text: string | undefined;
  let manifestError: unknown;
  const artifacts = z
    .object({
      value: z.array(
        z.object({
          name: z.string(),
          source: guid.optional(),
          resource: z.object({ downloadUrl: z.string() }).optional(),
        }),
      ),
    })
    .parse(await get(`${buildApi}/artifacts?api-version=7.1`, adoHeaders));
  const artifactName = `spec-gen-sdk-metadata-${stage.attempt}-${job.attempt}`;
  const matching = artifacts.value.filter((artifact) => artifact.name === artifactName);
  const artifact = matching.length === 1 ? matching[0] : undefined;
  let failureReason = "missing manifest or incorrect source job identity";
  if (artifact?.source?.toLowerCase() !== job.id.toLowerCase() || !artifact?.resource) {
    manifestError = new Error("Missing SDK metadata artifact for the current source job attempt");
  } else {
    const downloadUrl = new URL(artifact.resource.downloadUrl);
    const expectedUrl = new URL(`${buildApi}/artifacts`);
    if (
      downloadUrl.origin !== expectedUrl.origin ||
      downloadUrl.pathname.toLowerCase() !== expectedUrl.pathname.toLowerCase() ||
      downloadUrl.searchParams.get("artifactName") !== artifactName ||
      downloadUrl.username ||
      downloadUrl.password
    ) {
      throw new Error("Artifact download URL does not belong to the source build");
    }
    downloadUrl.searchParams.delete("$format");
    downloadUrl.searchParams.delete("format");
    const manifest = await downloadAzurePipelineArtifactFile({
      artifact: { artifactName, downloadUrl: downloadUrl.href, headers: adoHeaders },
      artifactFileName: "spec-gen-sdk-artifact.json",
      maxBytes: MAX_MANIFEST_BYTES,
      fetchImpl: (url, init) => fetchImpl(url, { ...init, signal: AbortSignal.timeout(30_000) }),
      retryOptions: { maxRetries: 0 },
    });
    try {
      text = encodeMetadata(
        manifest,
        identity,
        sourceCheck,
        headSha,
        build.triggerInfo["pr.number"],
      );
    } catch (error) {
      failureReason = "manifest failed schema, PR/head correlation, or output-size validation";
      manifestError = error;
    }
  }

  // Re-read before writing: an intervening native retry must not receive the old attempt's metadata.
  const [latestChecks, buildData, timelineData] = await Promise.all([
    listChecks(headSha),
    get(`${buildApi}?api-version=7.1`, adoHeaders),
    get(`${buildApi}/timeline?api-version=7.1`, adoHeaders),
  ]);
  const current = latestChecks
    .filter(
      (check) =>
        check.app.id === 9426 &&
        check.external_id?.toLowerCase() === nativeExternalId.toLowerCase(),
    )
    .sort((a, b) => b.id - a.id)[0];
  const currentBuild = buildSchema.parse(buildData);
  const currentTimeline = timelineSchema.parse(timelineData);
  if (
    current?.id !== native.id ||
    current.status !== "completed" ||
    current.started_at !== native.started_at ||
    current.completed_at !== native.completed_at ||
    current.head_sha !== headSha ||
    current.name !== native.name ||
    current.details_url !== native.details_url ||
    currentBuild.id !== buildId ||
    !currentTimeline.records.some(
      (record) =>
        record.id === stage.id && record.attempt === stage.attempt && record.state === "completed",
    ) ||
    !currentTimeline.records.some(
      (record) =>
        record.id === job.id &&
        record.attempt === job.attempt &&
        record.state === "completed" &&
        record.finishTime === job.finishTime,
    )
  ) {
    throw new Error("Source build/check changed during metadata publication");
  }

  const output = {
    title: text ? "SDK metadata available" : "SDK metadata unavailable",
    summary: text
      ? `Full SDK generation manifest for native check ${native.id}, build ${buildId}, stage attempt ${stage.attempt}, job attempt ${job.attempt}. This neutral check reports metadata transport, not generation success.`
      : `No valid complete SDK manifest could be published for build ${buildId}, stage attempt ${stage.attempt}, job attempt ${job.attempt}: ${failureReason}. SDK generation status remains on the native pipeline check.`,
    ...(text === undefined ? {} : { text }),
  };
  const conclusion = text ? "neutral" : "failure";
  const existing = latestChecks.filter(
    (check) => check.app.id === publisherAppId && check.external_id === externalId,
  );
  if (existing.length) {
    const previous = existing[0];
    if (
      existing.length !== 1 ||
      previous.name !== name ||
      previous.head_sha !== headSha ||
      previous.details_url !== detailsUrl ||
      previous.status !== "completed" ||
      previous.conclusion !== conclusion ||
      (previous.output.text ?? undefined) !== text ||
      previous.output.summary !== output.summary
    ) {
      throw new Error("Conflicting publication for an immutable SDK metadata identity");
    }
    if (manifestError)
      throw new Error(`SDK metadata unavailable: ${failureReason}`, { cause: manifestError });
    return "unchanged";
  }
  const response = await fetchImpl(`${githubApi}/check-runs`, {
    method: "POST",
    headers: githubHeaders,
    signal: AbortSignal.timeout(30_000),
    body: JSON.stringify({
      name,
      head_sha: headSha,
      external_id: externalId,
      details_url: detailsUrl,
      status: "completed",
      conclusion,
      output,
    }),
  });
  if (!response.ok)
    throw new Error(
      `SDK metadata check creation failed (${response.status}); inspect GitHub before retrying`,
    );
  const created = checkSchema.parse(await response.json());
  if (created.app.id !== publisherAppId)
    throw new Error("Check was created by an unexpected GitHub App");
  if (manifestError)
    throw new Error(`SDK metadata unavailable: ${failureReason}`, { cause: manifestError });
  return "created";
}
