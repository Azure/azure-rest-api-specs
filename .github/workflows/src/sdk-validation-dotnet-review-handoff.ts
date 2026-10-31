import fs from "node:fs";
import path from "node:path";
import { Unzip, UnzipInflate } from "fflate";
import * as z from "zod";
import {
  isSafeRelativePosixPath,
  SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE,
  SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE,
  SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES,
  SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES,
  SdkName,
  SpecGenSdkArtifactInfoSchema,
  type SpecGenSdkArtifactInfo,
} from "../../shared/src/sdk-types.ts";
import {
  downloadAzurePipelineArtifactArchive,
  downloadAzurePipelineArtifactFile,
  resolveAzurePipelineArtifact,
} from "./artifacts.ts";
import type { Context, Core, GitHub, GitHubScriptArgs } from "./github.ts";
import type { RetryOptions } from "./retries.ts";

export const EXPECTED_DOTNET_CHECK_NAME = "SDK Validation - .NET" as const;
export const EXPECTED_AZURE_PIPELINES_APP_NAME = "Azure Pipelines" as const;
export const EXPECTED_AZURE_PIPELINES_APP_SLUG = "azure-pipelines" as const;
export const EXPECTED_ADO_HOST = "dev.azure.com" as const;
export const EXPECTED_ADO_ORG = "azure-sdk" as const;
export const EXPECTED_ADO_DEFINITION_ID = 7516 as const;
export const SPEC_GEN_SDK_ARTIFACT_NAME = "spec-gen-sdk-artifact" as const;
export const SPEC_GEN_SDK_ARTIFACT_FILE_NAME = `${SPEC_GEN_SDK_ARTIFACT_NAME}.json` as const;
export const PACKAGES_ARTIFACT_NAME = "packages" as const;
export const MAX_SPEC_GEN_SDK_ARTIFACT_BYTES = 1024 * 1024;
export const MAX_PACKAGES_ARCHIVE_BYTES = 256 * 1024 * 1024;
export const MAX_SNAPSHOT_FILE_BYTES = 8 * 1024 * 1024;
export const MAX_SDK_REVIEW_PACKAGES = 128;

const CheckRunAppSchema = z
  .object({
    id: z.number().optional(),
    slug: z.string().optional(),
    name: z.string().optional(),
  })
  .optional();

const CheckRunPullRequestSchema = z.object({
  number: z.number().int().positive(),
  head: z
    .object({
      sha: z.string().optional(),
    })
    .optional(),
});

const CheckRunEventPayloadSchema = z.object({
  check_run: z.object({
    name: z.string(),
    head_sha: z.string().regex(/^[0-9a-f]{40}$/i, "Expected a 40-char check_run.head_sha"),
    details_url: z.string(),
    external_id: z.string(),
    status: z.string().optional(),
    conclusion: z.string().nullable().optional(),
    app: CheckRunAppSchema,
    check_suite: z
      .object({
        app: CheckRunAppSchema,
      })
      .optional(),
    pull_requests: z.array(CheckRunPullRequestSchema).optional(),
  }),
});

export type ValidatedAdoBuildTarget = {
  projectUrl: string;
  organization: string;
  project: string;
  buildId: string;
};

export type ValidatedCheckRunEvent = {
  checkName: string;
  headSha: string;
  conclusion: string | null | undefined;
  adoBuild: ValidatedAdoBuildTarget;
  eventPrNumbers: number[];
};

export type SdkReviewHandoffResult = {
  status: "validated" | "skipped";
  reason?: string;
  buildId?: string;
  prNumber?: number;
  headSha?: string;
  inputDirectory?: string;
  artifactPath?: string;
  summaryPath?: string;
  entryCount: number;
};

/**
 * Validates that an Azure DevOps `details_url` targets
 * `https://dev.azure.com/azure-sdk/<project>/_build/results?buildId=<numeric>`.
 * The required `check_run.external_id` must be exactly
 * `7516|<details_url buildId>|<details_url project>`.
 */
export function parseAndValidateAdoBuildDetailsUrl(
  detailsUrl: string | null | undefined,
  externalId?: string | null,
): ValidatedAdoBuildTarget {
  if (!detailsUrl) {
    throw new Error("Missing check_run.details_url for SDK Validation - .NET");
  }

  let parsedUrl: URL;
  try {
    parsedUrl = new URL(detailsUrl);
  } catch (error) {
    throw new Error(`Invalid check_run.details_url '${detailsUrl}'`, { cause: error });
  }

  if (parsedUrl.protocol !== "https:" || parsedUrl.hostname !== EXPECTED_ADO_HOST) {
    throw new Error(
      `Untrusted Azure DevOps host in details_url '${detailsUrl}' (expected https://${EXPECTED_ADO_HOST})`,
    );
  }
  if (parsedUrl.username || parsedUrl.password || parsedUrl.port) {
    throw new Error(`Disallowed credentials or port in details_url '${detailsUrl}'`);
  }

  const pathSegments = parsedUrl.pathname.split("/").filter((segment) => segment.length > 0);
  if (
    pathSegments.length !== 4 ||
    pathSegments[0] !== EXPECTED_ADO_ORG ||
    pathSegments[2] !== "_build" ||
    pathSegments[3] !== "results"
  ) {
    throw new Error(
      `Unexpected Azure DevOps path in details_url '${detailsUrl}' (expected /${EXPECTED_ADO_ORG}/<project>/_build/results)`,
    );
  }

  const project = pathSegments[1];
  if (!/^[A-Za-z0-9-]+$/.test(project)) {
    throw new Error(`Invalid Azure DevOps project identifier '${project}' in details_url`);
  }

  const buildId = parsedUrl.searchParams.get("buildId") ?? "";
  if (!/^[1-9]\d*$/.test(buildId)) {
    throw new Error(`Invalid or non-numeric buildId '${buildId}' in details_url '${detailsUrl}'`);
  }
  if (!externalId) {
    throw new Error("Missing check_run.external_id for SDK Validation - .NET");
  }

  const externalParts = externalId.split("|");
  if (externalParts.length !== 3 || externalParts.some((part) => part.length === 0)) {
    throw new Error(
      `Malformed check_run.external_id '${externalId}' (expected <definitionId>|<buildId>|<projectId>)`,
    );
  }
  const [definitionId, externalBuildId, externalProjectId] = externalParts;
  if (definitionId !== String(EXPECTED_ADO_DEFINITION_ID)) {
    throw new Error(
      `Unexpected Azure Pipelines definition ID '${definitionId}' (expected '${EXPECTED_ADO_DEFINITION_ID}')`,
    );
  }
  if (externalBuildId !== buildId) {
    throw new Error(
      `Mismatch between details_url buildId '${buildId}' and check_run.external_id '${externalId}'`,
    );
  }
  if (externalProjectId !== project) {
    throw new Error(
      `Mismatch between details_url project '${project}' and check_run.external_id '${externalId}'`,
    );
  }

  return {
    projectUrl: `https://${EXPECTED_ADO_HOST}/${EXPECTED_ADO_ORG}/${project}`,
    organization: EXPECTED_ADO_ORG,
    project,
    buildId,
  };
}

export function validateCheckRunEventPayload(payload: unknown): {
  matched: boolean;
  reason?: string;
  event?: ValidatedCheckRunEvent;
} {
  const parsed = CheckRunEventPayloadSchema.safeParse(payload);
  if (!parsed.success) {
    return {
      matched: false,
      reason: `Event payload does not match check_run schema: ${parsed.error.message}`,
    };
  }

  const checkRun = parsed.data.check_run;
  if (checkRun.name !== EXPECTED_DOTNET_CHECK_NAME) {
    return {
      matched: false,
      reason: `Ignoring check_run '${checkRun.name}' (expected '${EXPECTED_DOTNET_CHECK_NAME}')`,
    };
  }

  const appName = checkRun.app?.name ?? checkRun.check_suite?.app?.name;
  const appSlug = checkRun.app?.slug ?? checkRun.check_suite?.app?.slug;
  if (appName !== EXPECTED_AZURE_PIPELINES_APP_NAME) {
    return {
      matched: false,
      reason: `Ignoring check_run from app '${appName ?? "missing"}' (expected '${EXPECTED_AZURE_PIPELINES_APP_NAME}')`,
    };
  }
  if (appSlug !== EXPECTED_AZURE_PIPELINES_APP_SLUG) {
    return {
      matched: false,
      reason: `Ignoring check_run from app slug '${appSlug ?? "missing"}' (expected '${EXPECTED_AZURE_PIPELINES_APP_SLUG}')`,
    };
  }
  if (checkRun.status !== "completed") {
    return {
      matched: false,
      reason: `Ignoring non-terminal check_run with status '${checkRun.status ?? "unknown"}'`,
    };
  }

  return {
    matched: true,
    event: {
      checkName: checkRun.name,
      headSha: checkRun.head_sha,
      conclusion: checkRun.conclusion,
      adoBuild: parseAndValidateAdoBuildDetailsUrl(checkRun.details_url, checkRun.external_id),
      eventPrNumbers: (checkRun.pull_requests ?? []).map((pr) => pr.number),
    },
  };
}

function validatePullRequestRepository(
  context: Context,
  prNumber: number,
  pullRequest: {
    base: { repo?: { full_name?: string | null } | null };
  },
): void {
  const expectedRepository = `${context.repo.owner}/${context.repo.repo}`;
  const actualRepository = pullRequest.base.repo?.full_name;
  if (actualRepository && actualRepository.toLowerCase() !== expectedRepository.toLowerCase()) {
    throw new Error(`PR #${prNumber} targets '${actualRepository}', not '${expectedRepository}'`);
  }
}

/**
 * Binds SDK review metadata to the trusted .NET validation check run.
 *
 * This validates immutable spec identity and requires every package entry to
 * contain the complete baseline and source-snapshot contract before any
 * packages artifact is downloaded.
 *
 * @returns The validated specification pull request number.
 */
export function verifyReviewInputAgainstCheckRun(
  artifact: SpecGenSdkArtifactInfo,
  event: ValidatedCheckRunEvent,
): number {
  if (artifact.language !== SdkName.Net) {
    throw new Error(`Unexpected SDK language '${artifact.language}' in spec generation artifact`);
  }
  if (!/^[0-9a-f]{40}$/i.test(artifact.headSha)) {
    throw new Error(`Invalid headSha '${artifact.headSha}' in spec generation artifact`);
  }
  if (artifact.headSha.toLowerCase() !== event.headSha.toLowerCase()) {
    throw new Error(
      `Artifact headSha '${artifact.headSha}' does not match check_run.head_sha '${event.headSha}'`,
    );
  }

  const prNumber = Number.parseInt(artifact.prNumber ?? "", 10);
  if (!Number.isSafeInteger(prNumber) || prNumber <= 0) {
    throw new Error(`Invalid prNumber '${artifact.prNumber ?? ""}' in spec generation artifact`);
  }
  if (event.eventPrNumbers.length > 0 && !event.eventPrNumbers.includes(prNumber)) {
    throw new Error(
      `Artifact PR #${prNumber} is not in check_run.pull_requests [${event.eventPrNumbers.join(", ")}]`,
    );
  }
  if (artifact.apiViewRequestData.length > MAX_SDK_REVIEW_PACKAGES) {
    throw new Error(
      `Artifact has ${artifact.apiViewRequestData.length} APIView entries; maximum is ${MAX_SDK_REVIEW_PACKAGES}`,
    );
  }

  const seenPackages = new Set<string>();
  for (const request of artifact.apiViewRequestData) {
    if (
      !request.packageRootPath ||
      !request.changedFiles ||
      !request.sdkBaseCommitSha ||
      !request.reviewInputPath ||
      request.reviewInputFileCount === undefined ||
      request.reviewInputBytes === undefined
    ) {
      throw new Error(
        `APIView entry '${request.packageName}' is missing complete SDK review input metadata`,
      );
    }
    if (!isSafeRelativePosixPath(request.filePath)) {
      throw new Error(
        `APIView entry '${request.packageName}' has unsafe artifact path '${request.filePath}'`,
      );
    }
    if (seenPackages.has(request.packageName)) {
      throw new Error(`Duplicate APIView package '${request.packageName}'`);
    }
    seenPackages.add(request.packageName);
  }

  return prNumber;
}

function validateArchiveEntryName(name: string): void {
  if (
    name.length === 0 ||
    name.startsWith("/") ||
    name.startsWith("\\") ||
    /^[A-Za-z]:/.test(name) ||
    name.includes("\\") ||
    name.split("/").some((segment) => segment === "." || segment === "..") ||
    [...name].some((character) => {
      const codePoint = character.codePointAt(0) ?? 0;
      return codePoint <= 0x1f || codePoint === 0x7f;
    })
  ) {
    throw new Error(`Unsafe ZIP entry '${name}'`);
  }
}

function resolveDeclaredSnapshotFile(
  archiveEntryName: string,
  reviewInputPaths: readonly string[],
): { reviewInputPath: string; relativeFilePath: string } | undefined {
  for (const reviewInputPath of reviewInputPaths) {
    for (const artifactPrefix of ["", `${PACKAGES_ARTIFACT_NAME}/`]) {
      const snapshotPrefix = `${artifactPrefix}${reviewInputPath}/`;
      if (!archiveEntryName.startsWith(snapshotPrefix)) {
        continue;
      }
      const relativeFilePath = archiveEntryName.slice(snapshotPrefix.length);
      if (!isSafeRelativePosixPath(relativeFilePath)) {
        throw new Error(`Unsafe snapshot file path '${archiveEntryName}'`);
      }
      return { reviewInputPath, relativeFilePath };
    }
  }
  return undefined;
}

/**
 * Extracts only declared package snapshots from the existing packages ZIP.
 *
 * Every ZIP path is checked before extraction. Per-file, per-package, and
 * aggregate limits are enforced while streaming, and the extracted file counts
 * and byte totals must exactly match the trusted manifest.
 *
 * @throws When the archive contains unsafe, duplicate, missing, incomplete, or
 * oversized review input.
 */
export function extractAndValidateSdkReviewInputArchive(
  archiveBytes: Uint8Array,
  artifact: SpecGenSdkArtifactInfo,
  outputDirectory: string,
): void {
  const requests = artifact.apiViewRequestData;
  const reviewInputPaths = requests.map((request) => request.reviewInputPath!);
  if (
    new Set(reviewInputPaths.map((value) => value.toLowerCase())).size !== reviewInputPaths.length
  ) {
    throw new Error("Duplicate reviewInputPath values are not allowed");
  }

  const snapshotStats = new Map<string, { fileCount: number; bytes: number }>(
    reviewInputPaths.map((reviewInputPath) => [reviewInputPath, { fileCount: 0, bytes: 0 }]),
  );
  const seenArchiveEntries = new Set<string>();
  let totalExpandedBytes = 0;
  let extractedFileCount = 0;

  const unzip = new Unzip((file) => {
    validateArchiveEntryName(file.name);
    if (file.name.endsWith("/")) {
      return;
    }

    const declaredFile = resolveDeclaredSnapshotFile(file.name, reviewInputPaths);
    if (!declaredFile) {
      return;
    }

    const normalizedName = file.name.toLowerCase();
    if (seenArchiveEntries.has(normalizedName)) {
      throw new Error(`Duplicate ZIP entry '${file.name}'`);
    }
    seenArchiveEntries.add(normalizedName);

    const chunks: Uint8Array[] = [];
    let fileExpandedBytes = 0;
    file.ondata = (error, chunk, final) => {
      if (error) {
        throw error;
      }
      fileExpandedBytes += chunk.byteLength;
      totalExpandedBytes += chunk.byteLength;
      if (fileExpandedBytes > MAX_SNAPSHOT_FILE_BYTES) {
        throw new Error(`ZIP entry '${file.name}' exceeds ${MAX_SNAPSHOT_FILE_BYTES} bytes`);
      }
      if (totalExpandedBytes > SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES) {
        throw new Error(
          `ZIP expanded review input exceeds ${SDK_REVIEW_MAX_TOTAL_SNAPSHOT_BYTES} bytes`,
        );
      }
      if (chunk.byteLength > 0) {
        chunks.push(chunk.slice());
      }
      if (!final) {
        return;
      }

      const fileBytes = new Uint8Array(fileExpandedBytes);
      let offset = 0;
      for (const fileChunk of chunks) {
        fileBytes.set(fileChunk, offset);
        offset += fileChunk.byteLength;
      }

      const outputPath = path.resolve(
        outputDirectory,
        ...declaredFile.reviewInputPath.split("/"),
        ...declaredFile.relativeFilePath.split("/"),
      );
      const resolvedOutputDirectory = path.resolve(outputDirectory);
      if (
        outputPath !== resolvedOutputDirectory &&
        !outputPath.startsWith(`${resolvedOutputDirectory}${path.sep}`)
      ) {
        throw new Error(`ZIP entry '${file.name}' resolves outside output directory`);
      }
      fs.mkdirSync(path.dirname(outputPath), { recursive: true });
      fs.writeFileSync(outputPath, fileBytes);

      const stats = snapshotStats.get(declaredFile.reviewInputPath)!;
      stats.fileCount += 1;
      stats.bytes += fileExpandedBytes;
      extractedFileCount += 1;
      if (extractedFileCount > SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES) {
        throw new Error(`ZIP review input exceeds ${SDK_REVIEW_MAX_TOTAL_SNAPSHOT_FILES} files`);
      }
      if (stats.fileCount > SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE) {
        throw new Error(
          `Snapshot '${declaredFile.reviewInputPath}' exceeds ${SDK_REVIEW_MAX_SNAPSHOT_FILES_PER_PACKAGE} files`,
        );
      }
      if (stats.bytes > SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE) {
        throw new Error(
          `Snapshot '${declaredFile.reviewInputPath}' exceeds ${SDK_REVIEW_MAX_SNAPSHOT_BYTES_PER_PACKAGE} bytes`,
        );
      }
    };
    file.start();
  });
  unzip.register(UnzipInflate);
  unzip.push(archiveBytes, true);

  if (extractedFileCount !== seenArchiveEntries.size) {
    throw new Error("ZIP archive contains an incomplete review input entry");
  }

  for (const request of requests) {
    const stats = snapshotStats.get(request.reviewInputPath!)!;
    if (
      stats.fileCount !== request.reviewInputFileCount ||
      stats.bytes !== request.reviewInputBytes
    ) {
      throw new Error(
        `Snapshot '${request.reviewInputPath}' has ${stats.fileCount} files and ${stats.bytes} bytes; expected ${request.reviewInputFileCount} files and ${request.reviewInputBytes} bytes`,
      );
    }
  }
}

export async function verifyPullRequestFreshness(params: {
  github: GitHub;
  context: Context;
  prNumber: number;
  expectedHeadSha: string;
}): Promise<{ currentHeadSha: string; isFresh: boolean; state: string }> {
  const { github, context, prNumber, expectedHeadSha } = params;
  const { data: pullRequest } = await github.rest.pulls.get({
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: prNumber,
  });

  validatePullRequestRepository(context, prNumber, pullRequest);
  const currentHeadSha = pullRequest.head.sha;
  return {
    currentHeadSha,
    isFresh:
      pullRequest.state === "open" &&
      currentHeadSha.toLowerCase() === expectedHeadSha.toLowerCase(),
    state: pullRequest.state,
  };
}

export function formatReviewHandoffSummary(params: {
  event: ValidatedCheckRunEvent;
  artifact: SpecGenSdkArtifactInfo;
  prNumber: number;
}): string {
  const { event, artifact, prNumber } = params;
  const lines = [
    "## SDK Validation - .NET Naming Review Input (Report-Only)",
    "",
    `- **Spec PR**: #${prNumber}`,
    `- **Spec Head SHA**: \`${artifact.headSha}\``,
    `- **Azure Pipelines Build ID**: \`${event.adoBuild.buildId}\``,
    `- **Check Conclusion**: \`${event.conclusion ?? "unknown"}\``,
    `- **APIView Package Entries**: ${artifact.apiViewRequestData.length}`,
    "",
    "| Package | SDK Baseline | Package Root | Changed Files | Snapshot Files | Snapshot Bytes |",
    "| --- | --- | --- | ---: | ---: | ---: |",
  ];

  for (const request of artifact.apiViewRequestData) {
    lines.push(
      `| \`${request.packageName}\` | \`${request.sdkBaseCommitSha}\` | \`${request.packageRootPath}\` | ${request.changedFiles?.length ?? 0} | ${request.reviewInputFileCount ?? 0} | ${request.reviewInputBytes ?? 0} |`,
    );
  }

  return `${lines.join("\n")}\n`;
}

export type RunSdkValidationDotnetReviewHandoffOptions = {
  github: GitHub;
  context: Context;
  core: Core;
  outputRootDir?: string;
  token?: string;
  retryOptions?: RetryOptions;
  fetchImpl?: typeof fetch;
};

export async function runSdkValidationDotnetReviewHandoffImpl(
  options: RunSdkValidationDotnetReviewHandoffOptions,
): Promise<SdkReviewHandoffResult> {
  const {
    github,
    context,
    core,
    outputRootDir = path.join(process.cwd(), "out", "sdk-review-handoff"),
    token = process.env.ADO_TOKEN,
    retryOptions,
    fetchImpl = fetch,
  } = options;

  const eventValidation = validateCheckRunEventPayload(context.payload);
  if (!eventValidation.matched || !eventValidation.event) {
    const reason = eventValidation.reason ?? "Check run did not match target filter";
    core.info(reason);
    return { status: "skipped", reason, entryCount: 0 };
  }

  const event = eventValidation.event;
  if (event.eventPrNumbers.length > 0) {
    const primaryPrNumber = event.eventPrNumbers[0];
    const prStatus = await verifyPullRequestFreshness({
      github,
      context,
      prNumber: primaryPrNumber,
      expectedHeadSha: event.headSha,
    });
    if (!prStatus.isFresh) {
      const reason = `Skipping stale or closed PR #${primaryPrNumber}: state='${prStatus.state}', currentHeadSha='${prStatus.currentHeadSha}', checkRunHeadSha='${event.headSha}'`;
      core.info(reason);
      return {
        status: "skipped",
        reason,
        buildId: event.adoBuild.buildId,
        prNumber: primaryPrNumber,
        headSha: event.headSha,
        entryCount: 0,
      };
    }
  }

  const artifactResolution = await resolveAzurePipelineArtifact({
    ado_project_url: event.adoBuild.projectUrl,
    ado_build_id: event.adoBuild.buildId,
    artifactName: SPEC_GEN_SDK_ARTIFACT_NAME,
    token,
    core,
    fallbackToFailedArtifact: true,
    retryOptions,
    fetchImpl,
  });
  if (artifactResolution.status === "not-found") {
    const reason = `No '${SPEC_GEN_SDK_ARTIFACT_NAME}' artifact found on build ${event.adoBuild.buildId}`;
    core.info(reason);
    return {
      status: "skipped",
      reason,
      buildId: event.adoBuild.buildId,
      headSha: event.headSha,
      entryCount: 0,
    };
  }

  const artifactData = await downloadAzurePipelineArtifactFile({
    artifact: artifactResolution.artifact,
    artifactFileName: SPEC_GEN_SDK_ARTIFACT_FILE_NAME,
    retryOptions,
    maxBytes: MAX_SPEC_GEN_SDK_ARTIFACT_BYTES,
    fetchImpl,
  });

  let parsedArtifact: unknown;
  try {
    parsedArtifact = JSON.parse(artifactData);
  } catch (error) {
    throw new Error(`Invalid JSON in '${SPEC_GEN_SDK_ARTIFACT_FILE_NAME}'`, { cause: error });
  }
  const artifact = SpecGenSdkArtifactInfoSchema.parse(parsedArtifact);
  const prNumber = verifyReviewInputAgainstCheckRun(artifact, event);

  const prStatus = await verifyPullRequestFreshness({
    github,
    context,
    prNumber,
    expectedHeadSha: event.headSha,
  });
  if (!prStatus.isFresh) {
    const reason = `Skipping stale or closed PR #${prNumber}: state='${prStatus.state}', currentHeadSha='${prStatus.currentHeadSha}', checkRunHeadSha='${event.headSha}'`;
    core.info(reason);
    return {
      status: "skipped",
      reason,
      buildId: event.adoBuild.buildId,
      prNumber,
      headSha: event.headSha,
      entryCount: 0,
    };
  }

  const packagesArtifactResolution = await resolveAzurePipelineArtifact({
    ado_project_url: event.adoBuild.projectUrl,
    ado_build_id: event.adoBuild.buildId,
    artifactName: PACKAGES_ARTIFACT_NAME,
    token,
    core,
    fallbackToFailedArtifact: true,
    retryOptions,
    fetchImpl,
  });
  if (packagesArtifactResolution.status === "not-found") {
    throw new Error(
      `No '${PACKAGES_ARTIFACT_NAME}' artifact found on build ${event.adoBuild.buildId}`,
    );
  }
  const packagesArchiveBytes = await downloadAzurePipelineArtifactArchive({
    artifact: packagesArtifactResolution.artifact,
    retryOptions,
    maxBytes: MAX_PACKAGES_ARCHIVE_BYTES,
    fetchImpl,
  });

  const inputDirectory = path.resolve(outputRootDir, `build-${event.adoBuild.buildId}`);
  fs.mkdirSync(inputDirectory, { recursive: true });
  extractAndValidateSdkReviewInputArchive(packagesArchiveBytes, artifact, inputDirectory);
  const artifactPath = path.join(inputDirectory, SPEC_GEN_SDK_ARTIFACT_FILE_NAME);
  fs.writeFileSync(artifactPath, JSON.stringify(artifact, undefined, 2), "utf8");

  const summaryMarkdown = formatReviewHandoffSummary({ event, artifact, prNumber });
  const summaryPath = path.resolve(
    outputRootDir,
    `build-${event.adoBuild.buildId}-review-handoff-summary.md`,
  );
  fs.writeFileSync(summaryPath, summaryMarkdown, "utf8");
  await core.summary.addRaw(summaryMarkdown).write();

  core.setOutput("handoff_status", "validated");
  core.setOutput("input_dir", inputDirectory);
  core.setOutput("summary_path", summaryPath);
  core.setOutput("pr_number", String(prNumber));
  core.setOutput("head_sha", event.headSha);
  core.setOutput("build_id", event.adoBuild.buildId);

  return {
    status: "validated",
    buildId: event.adoBuild.buildId,
    prNumber,
    headSha: event.headSha,
    inputDirectory,
    artifactPath,
    summaryPath,
    entryCount: artifact.apiViewRequestData.length,
  };
}

export default async function runSdkValidationDotnetReviewHandoff({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<SdkReviewHandoffResult> {
  return runSdkValidationDotnetReviewHandoffImpl({ github, context, core });
}
