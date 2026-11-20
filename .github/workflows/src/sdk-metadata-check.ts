/**
 * The SDK generation job can copy `spec-gen-sdk-artifact.json` into a companion check run created by
 * a dedicated GitHub App (eng/tools/spec-gen-sdk-runner/src/publish-sdk-metadata.ts), with the same
 * `external_id` as the build's Azure Pipelines check. Workflows read it from there when available,
 * which is required where they can't authenticate to Azure DevOps (azure-rest-api-specs-pr), and
 * otherwise fall back to downloading the Azure DevOps artifact (e.g. fork PR builds, which can't use
 * the App's credentials).
 */
export function getSdkMetadataAppId(): number | undefined {
  const value = process.env.SDK_METADATA_APP_ID;
  if (!value) {
    return undefined;
  }
  const appId = Number(value);
  if (!Number.isSafeInteger(appId) || appId <= 0) {
    throw new Error(`SDK_METADATA_APP_ID must be a GitHub App ID, got '${value}'`);
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
  if (appId === undefined || !externalId) {
    return "";
  }
  const metadata = checks
    .filter((check) => check.app?.id === appId && check.external_id?.toLowerCase() === externalId)
    .sort((a, b) => Number(b.id) - Number(a.id))[0];
  if (!metadata?.output?.text) {
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
