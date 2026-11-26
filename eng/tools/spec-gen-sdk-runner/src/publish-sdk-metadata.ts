import { SpecGenSdkArtifactInfoSchema } from "@azure-tools/specs-shared/sdk-types";
import { readFile } from "node:fs/promises";

// GitHub's limit for a check run's output.text (measured in bytes to stay on the safe side).
const MAX_CHECK_TEXT_BYTES = 65_535;

export interface PublishSdkMetadataOptions {
  /** Contents of spec-gen-sdk-artifact.json. */
  manifest: string;
  /** "owner/repo" receiving the check. */
  repository: string;
  collectionUri: string;
  projectId: string;
  definitionId: string;
  buildId: string;
  jobAttempt: string;
  githubToken: string;
  fetchImpl?: typeof fetch;
}

/**
 * Copies the SDK generation manifest into a GitHub check run, so azure-rest-api-specs-pr workflows
 * can read it without Azure DevOps credentials (see .github/workflows/src/sdk-metadata-check.ts).
 * The check shares the `external_id` of the build's Azure Pipelines check.
 */
export async function publishSdkMetadata({
  manifest,
  repository,
  collectionUri,
  projectId,
  definitionId,
  buildId,
  jobAttempt,
  githubToken,
  fetchImpl = fetch,
}: PublishSdkMetadataOptions): Promise<void> {
  const artifact = SpecGenSdkArtifactInfoSchema.parse(JSON.parse(manifest));
  const text = JSON.stringify(JSON.parse(manifest));
  if (Buffer.byteLength(text, "utf8") > MAX_CHECK_TEXT_BYTES) {
    throw new Error(`SDK metadata exceeds the ${MAX_CHECK_TEXT_BYTES}-byte check output limit`);
  }
  const response = await fetchImpl(`https://api.github.com/repos/${repository}/check-runs`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${githubToken}`,
      Accept: "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
    },
    body: JSON.stringify({
      name: `SDK metadata - ${artifact.language} (${definitionId})`,
      head_sha: artifact.headSha,
      external_id: `${definitionId}|${buildId}|${projectId}`,
      details_url: `${collectionUri}${projectId}/_build/results?buildId=${buildId}`,
      status: "completed",
      conclusion: "neutral",
      completed_at: new Date().toISOString(),
      output: {
        title: "SDK generation metadata",
        summary: `spec-gen-sdk-artifact.json from build ${buildId} (job attempt ${jobAttempt}). SDK generation results are reported by the Azure Pipelines check.`,
        text,
      },
    }),
  });
  if (!response.ok) {
    throw new Error(`Failed to create SDK metadata check: ${response.status}`);
  }
}

if (import.meta.main) {
  const env = (name: string) => {
    const value = process.env[name];
    if (!value) throw new Error(`Missing environment variable ${name}`);
    return value;
  };
  const [manifestPath] = process.argv.slice(2);
  await publishSdkMetadata({
    manifest: await readFile(manifestPath, "utf8"),
    repository: env("BUILD_REPOSITORY_NAME"),
    collectionUri: env("SYSTEM_COLLECTIONURI"),
    projectId: env("SYSTEM_TEAMPROJECTID"),
    definitionId: env("SYSTEM_DEFINITIONID"),
    buildId: env("BUILD_BUILDID"),
    jobAttempt: env("SYSTEM_JOBATTEMPT"),
    githubToken: env("GH_TOKEN"),
  });
}
