import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import {
  nativeSdkBuildIdentity,
  parseSdkMetadata,
  sdkMetadataCheckName,
  sdkMetadataExternalIdPrefix,
  SdkMetadataIdSchema,
} from "../../shared/src/sdk-check-metadata.ts";
import type { SpecGenSdkArtifactInfo } from "../../shared/src/sdk-types.ts";
import type { CheckRuns, Core, GitHub } from "./github.ts";

const LANGUAGES: Record<string, SpecGenSdkArtifactInfo["language"]> = {
  "SDK Validation - .NET": "azure-sdk-for-net",
  "SDK Validation - .NET Libraries": "azure-sdk-for-net",
  "SDK Validation - .NET Provisioning Libraries": "azure-sdk-for-net",
  "SDK Validation - Java": "azure-sdk-for-java",
  "SDK Validation - Go": "azure-sdk-for-go",
  "SDK Validation - JS": "azure-sdk-for-js",
  "SDK Validation - JS Libraries": "azure-sdk-for-js",
  "SDK Validation - JS Provisioning Libraries": "azure-sdk-for-js",
  "SDK Validation - Python": "azure-sdk-for-python",
  "SDK Validation - Rust": "azure-sdk-for-rust",
};

export function isPrivateSdkRepository(owner: string, repo: string): boolean {
  return owner.toLowerCase() === "azure" && repo === "azure-rest-api-specs-pr";
}

function isNativeCheck(check: CheckRuns[number]): boolean {
  return (
    check.app?.id === 9426 &&
    check.app.slug === "azure-pipelines" &&
    check.name.startsWith("SDK Validation")
  );
}

function publisherAppId(): number {
  const value = process.env.SDK_METADATA_PUBLISHER_APP_ID ?? "";
  const id = Number(value);
  if (!/^[1-9]\d*$/.test(value) || !Number.isSafeInteger(id)) {
    throw new Error(
      "SDK_METADATA_PUBLISHER_APP_ID must identify the dedicated metadata writer App",
    );
  }
  return id;
}

/**
 * Read fresh API objects, not event-supplied output, and resolve the current PR before producing
 * downstream artifacts. Older native runs remain in the API but cannot override a newer run.
 */
export async function loadPrivateSdkChecks({
  github,
  core,
  owner,
  repo,
  headSha,
  issueNumber,
  eventCheckId,
}: {
  github: GitHub;
  core: Core;
  owner: string;
  repo: string;
  headSha: string;
  issueNumber?: number;
  eventCheckId?: number;
}) {
  const allChecks = await github.paginate(github.rest.checks.listForRef, {
    owner,
    repo,
    ref: headSha,
    filter: "all",
    per_page: PER_PAGE_MAX,
  });
  if (eventCheckId !== undefined) {
    const eventCheck = allChecks.find((check) => check.id === eventCheckId);
    if (
      !eventCheck ||
      eventCheck.head_sha !== headSha ||
      (!isNativeCheck(eventCheck) &&
        !(eventCheck.name.startsWith("SDK metadata / ") && eventCheck.app?.id === publisherAppId()))
    ) {
      throw new Error("Trigger is not an authenticated SDK validation or metadata check");
    }
  }
  const latest = new Map<string, CheckRuns[number]>();
  for (const check of allChecks.filter(isNativeCheck)) {
    if (check.head_sha !== headSha) {
      throw new Error("Native SDK check does not match the requested head SHA");
    }
    if (check.id > (latest.get(check.name)?.id ?? 0)) latest.set(check.name, check);
  }
  const checks = [...latest.values()];
  if (checks.length === 0) {
    if (eventCheckId !== undefined) throw new Error("Metadata has no native SDK validation check");
    core.info("No SDK Validation check runs found. Skipping status update.");
    return;
  }

  const prNumbers = new Set(
    checks.flatMap((check) => check.pull_requests?.map((pr) => pr.number) ?? []),
  );
  if (issueNumber && Number.isSafeInteger(issueNumber)) prNumbers.add(issueNumber);
  if (prNumbers.size === 0) {
    const prs = await github.paginate(github.rest.repos.listPullRequestsAssociatedWithCommit, {
      owner,
      repo,
      commit_sha: headSha,
      per_page: PER_PAGE_MAX,
    });
    for (const pr of prs) {
      if (
        pr.state === "open" &&
        pr.head.sha === headSha &&
        pr.base.repo.full_name.toLowerCase() === `${owner}/${repo}`.toLowerCase()
      ) {
        prNumbers.add(pr.number);
      }
    }
  }
  if (prNumbers.size !== 1) throw new Error("Cannot uniquely correlate SDK checks to a PR");
  const prNumber = [...prNumbers][0];
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: prNumber });
  if (pr.base.repo.full_name.toLowerCase() !== `${owner}/${repo}`.toLowerCase()) {
    throw new Error("SDK validation PR targets a different repository");
  }
  if (pr.state !== "open" || pr.head.sha !== headSha) {
    core.warning("Ignoring SDK checks for a closed PR or stale PR head");
    return;
  }
  core.setOutput("head_sha", headSha);
  core.setOutput("issue_number", prNumber);
  return { checks, allChecks, pr, prNumber };
}

export function readPrivateSdkArtifact(
  native: CheckRuns[number],
  allChecks: CheckRuns,
  prNumber: number,
): SpecGenSdkArtifactInfo {
  const expected = nativeSdkBuildIdentity(native);
  const appId = publisherAppId();
  const prefix = sdkMetadataExternalIdPrefix(expected);
  const candidates = allChecks.filter(
    (check) =>
      check.app?.id === appId &&
      check.name === sdkMetadataCheckName(expected.definitionId) &&
      check.head_sha === native.head_sha &&
      check.external_id?.startsWith(prefix),
  );
  if (candidates.length === 0) {
    throw new Error(`Missing SDK metadata for ${native.name}; publisher must complete or be rerun`);
  }
  const attempts = candidates.map((check) => {
    const parts = check.external_id!.slice(prefix.length).split(":");
    const [stageAttempt, jobAttempt] = parts.map(Number);
    if (
      parts.length !== 2 ||
      parts.some((part) => !/^[1-9]\d*$/.test(part)) ||
      !SdkMetadataIdSchema.safeParse(stageAttempt).success ||
      !SdkMetadataIdSchema.safeParse(jobAttempt).success
    ) {
      throw new Error(`Invalid SDK metadata attempt for ${native.name}`);
    }
    return { check, stageAttempt, jobAttempt };
  });
  attempts.sort((a, b) => b.stageAttempt - a.stageAttempt || b.jobAttempt - a.jobAttempt);
  const selected = attempts[0];
  const check = selected.check;
  const text = check.output.text;
  if (!text) {
    throw new Error(`Missing SDK metadata for ${native.name}`);
  }
  const { build, sourceCheck, artifact } = parseSdkMetadata(text);
  if (
    check.status !== "completed" ||
    check.conclusion !== "neutral" ||
    build.stageAttempt !== selected.stageAttempt ||
    build.jobAttempt !== selected.jobAttempt ||
    build.definitionId !== expected.definitionId ||
    build.buildId !== expected.buildId ||
    build.projectId !== expected.projectId ||
    check.details_url !== native.details_url ||
    artifact.headSha !== native.head_sha ||
    artifact.prNumber !== String(prNumber) ||
    artifact.language !== LANGUAGES[native.name.replace(/ - PR$/, "")]
  ) {
    throw new Error(`SDK metadata identity or transport mismatch for ${native.name}`);
  }
  if (
    sourceCheck.id !== native.id ||
    sourceCheck.name !== native.name ||
    sourceCheck.startedAt !== native.started_at ||
    sourceCheck.completedAt !== native.completed_at ||
    native.status !== "completed" ||
    (attempts[1]?.stageAttempt === selected.stageAttempt &&
      attempts[1]?.jobAttempt === selected.jobAttempt)
  ) {
    throw new Error(`Stale or duplicate SDK metadata for ${native.name}; rerun the publisher`);
  }
  if (["pending", "inProgress"].includes(artifact.result)) {
    throw new Error(`Finished SDK build has an incomplete manifest result for ${native.name}`);
  }
  return artifact;
}
