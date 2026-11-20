/**
 * Workflows in Azure/azure-rest-api-specs-pr can't authenticate to Azure DevOps to download
 * `spec-gen-sdk-artifact.json`. Instead, the SDK generation job copies it into a companion check
 * run created by a dedicated GitHub App (eng/tools/spec-gen-sdk-runner/src/publish-sdk-metadata.ts),
 * with the same `external_id` as the build's Azure Pipelines check.
 */
export function usesSdkMetadataChecks(owner: string, repo: string): boolean {
  return `${owner}/${repo}`.toLowerCase() === "azure/azure-rest-api-specs-pr";
}

export function getSdkMetadataAppId(): number {
  const appId = Number(process.env.SDK_METADATA_APP_ID);
  if (!Number.isSafeInteger(appId) || appId <= 0) {
    throw new Error("SDK_METADATA_APP_ID must be set to the SDK metadata GitHub App ID");
  }
  return appId;
}

type CheckRun = {
  id: number | bigint;
  external_id: string | null;
  started_at: string | null;
  completed_at?: string | null;
  app?: { id: number } | null;
  output?: { text?: string | null };
};

/**
 * Returns the manifest JSON published for the given Azure Pipelines check, or "" if its current
 * run hasn't published one.
 */
export function getSdkMetadataFromChecks(nativeCheck: CheckRun, checks: CheckRun[]): string {
  const appId = getSdkMetadataAppId();
  const externalId = nativeCheck.external_id?.toLowerCase();
  const metadata = checks
    .filter((check) => check.app?.id === appId && check.external_id?.toLowerCase() === externalId)
    .sort((a, b) => Number(b.id) - Number(a.id))[0];
  if (!externalId || !metadata?.output?.text) {
    return "";
  }
  // A rerun restarts the native check; metadata published before that belongs to an older attempt.
  if (
    nativeCheck.started_at &&
    Date.parse(metadata.completed_at ?? "") < Date.parse(nativeCheck.started_at)
  ) {
    return "";
  }
  return metadata.output.text;
}
