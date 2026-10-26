import { createHash } from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import * as z from "zod";
import {
  isSafeRelativePosixPath,
  SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
  SDK_REVIEW_BUNDLE_MAX_CHANGED_FILES_PER_ENTRY,
  SDK_REVIEW_BUNDLE_MAX_ENTRIES,
  SDK_REVIEW_BUNDLE_MAX_TOTAL_CHANGED_FILES,
  SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME,
  SdkName,
  SdkReviewBundleManifestSchema,
  type SdkReviewBundleEntry,
  type SdkReviewBundleManifest,
} from "../../shared/src/sdk-types.ts";
import { getAzurePipelineArtifact } from "./artifacts.ts";
import type { Context, Core, GitHub, GitHubScriptArgs } from "./github.ts";
import type { RetryOptions } from "./retries.ts";

export const EXPECTED_DOTNET_CHECK_NAME = "SDK Validation - .NET" as const;
export const EXPECTED_AZURE_PIPELINES_APP_NAME = "Azure Pipelines" as const;
export const EXPECTED_AZURE_PIPELINES_APP_SLUG = "azure-pipelines" as const;
export const EXPECTED_ADO_HOST = "dev.azure.com" as const;
export const EXPECTED_ADO_ORG = "azure-sdk" as const;
export const MAX_SDK_REVIEW_MANIFEST_BYTES = 1024 * 1024;
export const MAX_SDK_REVIEW_PATCH_BYTES = 16 * 1024 * 1024;
export const MAX_SDK_REVIEW_TOTAL_PATCH_BYTES = 16 * 1024 * 1024;
export {
  SDK_REVIEW_BUNDLE_MAX_CHANGED_FILES_PER_ENTRY as MAX_SDK_REVIEW_CHANGED_FILES_PER_ENTRY,
  SDK_REVIEW_BUNDLE_MAX_ENTRIES as MAX_SDK_REVIEW_ENTRIES,
  SDK_REVIEW_BUNDLE_MAX_TOTAL_CHANGED_FILES as MAX_SDK_REVIEW_TOTAL_CHANGED_FILES,
};

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
    details_url: z.string().nullable().optional(),
    external_id: z.string().nullable().optional(),
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

export type DownloadedBundleEntry = {
  entry: SdkReviewBundleEntry;
  localPatchPath: string;
};

type CompleteSdkReviewBundleManifest = Extract<
  SdkReviewBundleManifest,
  { captureStatus: "complete" }
>;

export type SdkReviewHandoffResult = {
  status: "validated" | "skipped";
  reason?: string;
  buildId?: string;
  prNumber?: number;
  headSha?: string;
  bundleDirectory?: string;
  manifestPath?: string;
  summaryPath?: string;
  entryCount: number;
};

/**
 * Validates that an Azure DevOps `details_url` targets `https://dev.azure.com/azure-sdk/<project>/_build/results?buildId=<numeric>`
 * and optionally cross-checks `check_run.external_id` (`<definitionId>|<buildId>|<projectId>`).
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

  if (externalId) {
    const externalParts = externalId.split("|");
    if (externalParts.length >= 2 && externalParts[1] && externalParts[1] !== buildId) {
      throw new Error(
        `Mismatch between details_url buildId '${buildId}' and check_run.external_id '${externalId}'`,
      );
    }
    if (externalParts.length >= 3 && externalParts[2] && externalParts[2] !== project) {
      throw new Error(
        `Mismatch between details_url project '${project}' and check_run.external_id '${externalId}'`,
      );
    }
  }

  return {
    projectUrl: `https://${EXPECTED_ADO_HOST}/${EXPECTED_ADO_ORG}/${project}`,
    organization: EXPECTED_ADO_ORG,
    project,
    buildId,
  };
}

/**
 * Validates the `check_run` event payload for `SDK Validation - .NET` from `Azure Pipelines`.
 * Returns `undefined` when the event is for a different check name or app so the workflow
 * can exit cleanly without failing unrelated check runs.
 */
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
  if (appName && appName !== EXPECTED_AZURE_PIPELINES_APP_NAME) {
    return {
      matched: false,
      reason: `Ignoring check_run from app '${appName}' (expected '${EXPECTED_AZURE_PIPELINES_APP_NAME}')`,
    };
  }
  if (appSlug && appSlug !== EXPECTED_AZURE_PIPELINES_APP_SLUG) {
    return {
      matched: false,
      reason: `Ignoring check_run from app slug '${appSlug}' (expected '${EXPECTED_AZURE_PIPELINES_APP_SLUG}')`,
    };
  }
  if (!appName && !appSlug) {
    return {
      matched: false,
      reason: "Ignoring check_run with missing app identity",
    };
  }

  const adoBuild = parseAndValidateAdoBuildDetailsUrl(checkRun.details_url, checkRun.external_id);
  const eventPrNumbers = (checkRun.pull_requests ?? []).map((pr) => pr.number);

  return {
    matched: true,
    event: {
      checkName: checkRun.name,
      headSha: checkRun.head_sha,
      conclusion: checkRun.conclusion,
      adoBuild,
      eventPrNumbers,
    },
  };
}

/**
 * Resolves a candidate file path inside `baseDir` and throws if it escapes `baseDir`.
 */
export function resolveSafeChildPath(baseDir: string, relativeFileName: string): string {
  if (!isSafeRelativePosixPath(relativeFileName) || relativeFileName.includes("/")) {
    throw new Error(`Unsafe bundle file name '${relativeFileName}'`);
  }
  const resolvedBase = path.resolve(baseDir);
  const resolvedTarget = path.resolve(resolvedBase, relativeFileName);
  const relative = path.relative(resolvedBase, resolvedTarget);
  if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) {
    throw new Error(`Bundle file path '${relativeFileName}' escapes '${resolvedBase}'`);
  }
  return resolvedTarget;
}

/**
 * Validates the parsed review bundle manifest against the check_run event and build metadata.
 */
export function verifyManifestAgainstCheckRun(
  manifest: SdkReviewBundleManifest,
  event: ValidatedCheckRunEvent,
): number {
  if (manifest.sdkLanguage !== SdkName.Net || manifest.sdkRepoName !== SdkName.Net) {
    throw new Error(
      `Unexpected SDK language/repo in manifest: ${manifest.sdkLanguage} / ${manifest.sdkRepoName}`,
    );
  }

  if (manifest.specHeadSha.toLowerCase() !== event.headSha.toLowerCase()) {
    throw new Error(
      `Manifest specHeadSha '${manifest.specHeadSha}' does not match check_run.head_sha '${event.headSha}'`,
    );
  }

  if (manifest.buildId && manifest.buildId !== event.adoBuild.buildId) {
    throw new Error(
      `Manifest buildId '${manifest.buildId}' does not match check_run buildId '${event.adoBuild.buildId}'`,
    );
  }

  const prNumber = Number.parseInt(manifest.specPrNumber, 10);
  if (!Number.isSafeInteger(prNumber) || prNumber <= 0) {
    throw new Error(`Invalid specPrNumber '${manifest.specPrNumber}' in manifest`);
  }

  if (event.eventPrNumbers.length > 0 && !event.eventPrNumbers.includes(prNumber)) {
    throw new Error(
      `Manifest specPrNumber #${prNumber} is not in check_run.pull_requests [${event.eventPrNumbers.join(", ")}]`,
    );
  }

  if (manifest.captureStatus === "failed") {
    throw new Error(
      `SDK review bundle capture failed for build ${event.adoBuild.buildId}: ${manifest.captureErrors.join("; ")}`,
    );
  }

  const seenEntryIds = new Set<string>();
  const seenPatchFiles = new Set<string>();
  let totalChangedFileCount = 0;
  let totalPatchBytes = 0;
  for (const entry of manifest.entries) {
    if (seenEntryIds.has(entry.entryId)) {
      throw new Error(`Duplicate entryId '${entry.entryId}' in review bundle manifest`);
    }
    seenEntryIds.add(entry.entryId);

    if (seenPatchFiles.has(entry.patchFile)) {
      throw new Error(`Duplicate patchFile '${entry.patchFile}' in review bundle manifest`);
    }
    seenPatchFiles.add(entry.patchFile);

    if (entry.changedFileCount !== entry.changedFiles.length) {
      throw new Error(
        `Entry '${entry.entryId}' changedFileCount (${entry.changedFileCount}) does not match changedFiles length (${entry.changedFiles.length})`,
      );
    }

    const seenChangedFiles = new Set<string>();
    for (const changedFile of entry.changedFiles) {
      if (!changedFile.startsWith(`${entry.packageRootPath}/`)) {
        throw new Error(
          `Entry '${entry.entryId}' changed file '${changedFile}' is not a strict descendant of packageRootPath '${entry.packageRootPath}'`,
        );
      }
      if (seenChangedFiles.has(changedFile)) {
        throw new Error(`Entry '${entry.entryId}' has duplicate changed file '${changedFile}'`);
      }
      seenChangedFiles.add(changedFile);
    }

    if (entry.patchBytes > MAX_SDK_REVIEW_PATCH_BYTES) {
      throw new Error(
        `Entry '${entry.entryId}' patchBytes (${entry.patchBytes}) exceeds ${MAX_SDK_REVIEW_PATCH_BYTES}`,
      );
    }
    totalChangedFileCount += entry.changedFiles.length;
    totalPatchBytes += entry.patchBytes;
  }

  if (manifest.entries.length > SDK_REVIEW_BUNDLE_MAX_ENTRIES) {
    throw new Error(`Manifest exceeds ${SDK_REVIEW_BUNDLE_MAX_ENTRIES} entries`);
  }
  if (totalChangedFileCount > SDK_REVIEW_BUNDLE_MAX_TOTAL_CHANGED_FILES) {
    throw new Error(
      `Manifest has ${totalChangedFileCount} changed files; maximum is ${SDK_REVIEW_BUNDLE_MAX_TOTAL_CHANGED_FILES}`,
    );
  }
  if (totalPatchBytes > MAX_SDK_REVIEW_TOTAL_PATCH_BYTES) {
    throw new Error(
      `Manifest declares ${totalPatchBytes} patch bytes; maximum is ${MAX_SDK_REVIEW_TOTAL_PATCH_BYTES}`,
    );
  }

  return prNumber;
}

export function verifyPatchPaths(entry: SdkReviewBundleEntry, patchText: string): void {
  const patchFiles = new Set<string>();
  for (const line of patchText.split(/\r?\n/)) {
    if (!line.startsWith("diff --git ")) {
      continue;
    }

    const header = line.slice("diff --git ".length);
    if (header.includes('"')) {
      throw new Error(`Patch '${entry.patchFile}' uses unsupported quoted diff paths`);
    }
    const matchedFile = entry.changedFiles.find(
      (changedFile) => header === `a/${changedFile} b/${changedFile}`,
    );
    if (!matchedFile) {
      throw new Error(
        `Patch '${entry.patchFile}' has an undeclared, renamed, or unsupported diff header '${line}'`,
      );
    }
    if (!isSafeRelativePosixPath(matchedFile)) {
      throw new Error(`Patch '${entry.patchFile}' contains an unsafe diff path '${matchedFile}'`);
    }
    if (patchFiles.has(matchedFile)) {
      throw new Error(`Patch '${entry.patchFile}' contains duplicate diff path '${matchedFile}'`);
    }
    patchFiles.add(matchedFile);
  }

  const declaredFiles = new Set(entry.changedFiles);
  const undeclaredFiles = [...patchFiles].filter((filePath) => !declaredFiles.has(filePath));
  const missingFiles = entry.changedFiles.filter((filePath) => !patchFiles.has(filePath));
  if (patchFiles.size === 0 && patchText.trim().length > 0) {
    throw new Error(`Patch '${entry.patchFile}' has content without a diff header`);
  }
  if (undeclaredFiles.length > 0 || missingFiles.length > 0) {
    throw new Error(
      `Patch '${entry.patchFile}' paths do not match changedFiles (undeclared: ${undeclaredFiles.join(", ") || "none"}; missing: ${missingFiles.join(", ") || "none"})`,
    );
  }
}

/**
 * Verifies with the GitHub Pulls API that the pull request is open in the current
 * repository and its current head SHA still matches `expectedHeadSha`.
 */
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

  if (
    pullRequest.base.repo &&
    pullRequest.base.repo.full_name.toLowerCase() !==
      `${context.repo.owner}/${context.repo.repo}`.toLowerCase()
  ) {
    throw new Error(
      `PR #${prNumber} targets '${pullRequest.base.repo.full_name}', not '${context.repo.owner}/${context.repo.repo}'`,
    );
  }

  const currentHeadSha = pullRequest.head.sha;
  const isFresh =
    pullRequest.state === "open" && currentHeadSha.toLowerCase() === expectedHeadSha.toLowerCase();

  return {
    currentHeadSha,
    isFresh,
    state: pullRequest.state,
  };
}

/**
 * Renders a deterministic markdown summary for the report-only handoff workflow.
 */
export function formatReviewHandoffSummary(params: {
  event: ValidatedCheckRunEvent;
  manifest: CompleteSdkReviewBundleManifest;
  prNumber: number;
  downloadedEntries: DownloadedBundleEntry[];
}): string {
  const { event, manifest, prNumber, downloadedEntries } = params;
  const lines = [
    "## SDK Validation - .NET Review Bundle Handoff (Report-Only)",
    "",
    `- **Spec PR**: #${prNumber}`,
    `- **Spec Head SHA**: \`${manifest.specHeadSha}\``,
    `- **Azure Pipelines Build ID**: \`${event.adoBuild.buildId}\``,
    `- **Check Conclusion**: \`${event.conclusion ?? "unknown"}\``,
    `- **SDK Repository**: \`${manifest.sdkRepoName}\``,
    `- **Captured Package Entries**: ${downloadedEntries.length}`,
    "",
    "| Entry ID | Package | SDK Base Commit | Result | Changed Files | Patch Bytes | Patch SHA-256 |",
    "| --- | --- | --- | --- | ---: | ---: | --- |",
  ];

  for (const { entry } of downloadedEntries) {
    lines.push(
      `| \`${entry.entryId}\` | \`${entry.packageName}\` (\`${entry.packageRootPath}\`) | \`${entry.sdkBaseCommitSha.slice(0, 12)}\` | \`${entry.executionResult}\` | ${entry.changedFileCount} | ${entry.patchBytes} | \`${entry.patchSha256.slice(0, 16)}...\` |`,
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
};

/**
 * Executes the consumer-side handoff validation and artifact download for
 * `SDK Validation - .NET` in report-only mode (no PR comments or issue mutations).
 */
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
  } = options;

  const eventValidation = validateCheckRunEventPayload(context.payload);
  if (!eventValidation.matched || !eventValidation.event) {
    const reason = eventValidation.reason ?? "Check run did not match target filter";
    core.info(reason);
    return {
      status: "skipped",
      reason,
      entryCount: 0,
    };
  }

  const event = eventValidation.event;
  core.info(
    `Validated check_run '${event.checkName}' for head '${event.headSha}' and Azure Pipelines build '${event.adoBuild.buildId}'`,
  );

  // If check_run.pull_requests is populated in the event payload, pre-check PR freshness
  // before downloading artifacts from Azure DevOps.
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

  const manifestArtifact = await getAzurePipelineArtifact({
    ado_project_url: event.adoBuild.projectUrl,
    ado_build_id: event.adoBuild.buildId,
    artifactName: SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
    artifactFileName: SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME,
    token,
    core,
    fallbackToFailedArtifact: true,
    retryOptions,
    strict: true,
    maxBytes: MAX_SDK_REVIEW_MANIFEST_BYTES,
  });

  if (manifestArtifact.status === "not-found") {
    const reason = `No '${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}' artifact found on build ${event.adoBuild.buildId}`;
    core.info(reason);
    return {
      status: "skipped",
      reason,
      buildId: event.adoBuild.buildId,
      headSha: event.headSha,
      entryCount: 0,
    };
  }

  if (Buffer.byteLength(manifestArtifact.artifactData, "utf8") > MAX_SDK_REVIEW_MANIFEST_BYTES) {
    throw new Error(
      `'${SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME}' exceeds ${MAX_SDK_REVIEW_MANIFEST_BYTES} bytes`,
    );
  }

  let parsedJson: unknown;
  try {
    parsedJson = JSON.parse(manifestArtifact.artifactData);
  } catch (error) {
    throw new Error(
      `Invalid JSON in '${SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME}' from build ${event.adoBuild.buildId}`,
      { cause: error },
    );
  }

  const manifest = SdkReviewBundleManifestSchema.parse(parsedJson);
  const prNumber = verifyManifestAgainstCheckRun(manifest, event);
  if (manifest.captureStatus !== "complete") {
    throw new Error(
      `SDK review bundle capture did not complete for build ${event.adoBuild.buildId}`,
    );
  }

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

  const bundleDirectory = path.resolve(outputRootDir, `build-${event.adoBuild.buildId}`);
  fs.mkdirSync(bundleDirectory, { recursive: true });

  const manifestPath = resolveSafeChildPath(bundleDirectory, SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME);
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, undefined, 2));

  const downloadedEntries: DownloadedBundleEntry[] = [];
  let remainingPatchBytes = MAX_SDK_REVIEW_TOTAL_PATCH_BYTES;
  for (const entry of manifest.entries) {
    const localPatchPath = resolveSafeChildPath(bundleDirectory, entry.patchFile);
    const patchResponse = await getAzurePipelineArtifact({
      ado_project_url: event.adoBuild.projectUrl,
      ado_build_id: event.adoBuild.buildId,
      artifactName: SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
      artifactFileName: entry.patchFile,
      token,
      core,
      fallbackToFailedArtifact: true,
      retryOptions,
      strict: true,
      maxBytes: Math.min(MAX_SDK_REVIEW_PATCH_BYTES, remainingPatchBytes),
    });

    if (patchResponse.status === "not-found") {
      throw new Error(
        `Missing patch file '${entry.patchFile}' for entry '${entry.entryId}' in build ${event.adoBuild.buildId}`,
      );
    }

    const patchBuffer = Buffer.from(patchResponse.artifactData, "utf8");
    if (patchBuffer.byteLength !== entry.patchBytes) {
      throw new Error(
        `Patch size mismatch for '${entry.patchFile}': expected ${entry.patchBytes} bytes, got ${patchBuffer.byteLength}`,
      );
    }

    const actualSha256 = createHash("sha256").update(patchBuffer).digest("hex");
    if (actualSha256.toLowerCase() !== entry.patchSha256.toLowerCase()) {
      throw new Error(
        `Patch SHA-256 mismatch for '${entry.patchFile}': expected ${entry.patchSha256}, got ${actualSha256}`,
      );
    }

    verifyPatchPaths(entry, patchResponse.artifactData);
    remainingPatchBytes -= patchBuffer.byteLength;
    fs.writeFileSync(localPatchPath, patchBuffer);
    downloadedEntries.push({ entry, localPatchPath });
  }

  const summaryMarkdown = formatReviewHandoffSummary({
    event,
    manifest,
    prNumber,
    downloadedEntries,
  });
  const summaryPath = resolveSafeChildPath(bundleDirectory, "review-handoff-summary.md");
  fs.writeFileSync(summaryPath, summaryMarkdown, "utf8");

  await core.summary.addRaw(summaryMarkdown).write();

  core.setOutput("handoff_status", "validated");
  core.setOutput("bundle_dir", bundleDirectory);
  core.setOutput("summary_path", summaryPath);
  core.setOutput("pr_number", String(prNumber));
  core.setOutput("head_sha", event.headSha);
  core.setOutput("build_id", event.adoBuild.buildId);

  return {
    status: "validated",
    buildId: event.adoBuild.buildId,
    prNumber,
    headSha: event.headSha,
    bundleDirectory,
    manifestPath,
    summaryPath,
    entryCount: downloadedEntries.length,
  };
}

export default async function runSdkValidationDotnetReviewHandoff({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<SdkReviewHandoffResult> {
  return runSdkValidationDotnetReviewHandoffImpl({
    github,
    context,
    core,
  });
}
