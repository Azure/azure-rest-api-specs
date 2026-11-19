import {
  generateTypeSpecMetadata,
  type TypeSpecLanguageMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { LogLevel, logMessage } from "./log.ts";

export interface EmitterCheckResult {
  enabled: boolean;
  metadata?: TypeSpecMetadata;
  languageKey?: string;
  packageName?: string;
}

/**
 * Maps an SDK repo name to the typespec-metadata language key.
 */
const SDK_REPO_TO_LANGUAGE_KEY: Record<string, string[]> = {
  "azure-sdk-for-python": ["python"],
  "azure-sdk-for-java": ["java"],
  "azure-sdk-for-net": ["csharp", "http-client-csharp", "http-client-csharp-mgmt"],
  "azure-sdk-for-js": ["typescript"],
  "azure-sdk-for-go": ["go"],
  "azure-sdk-for-rust": ["rust"],
};

/**
 * Resolves the language key from the SDK repo name by checking which key
 * exists in the typespec-metadata output.
 */
export function resolveLanguageKey(
  sdkRepoName: string,
  languages: Record<string, TypeSpecLanguageMetadata[]>,
): string | undefined {
  const normalizedName = sdkRepoName.replace("-pr", "");
  const candidates = SDK_REPO_TO_LANGUAGE_KEY[normalizedName];
  if (!candidates) {
    return undefined;
  }
  return candidates.find((key) => key in languages);
}

/**
 * Runs the typespec-metadata emitter to check if the target language emitter
 * is enabled in the tspconfig.yaml and extracts package metadata.
 *
 * @param tspConfigDir - Absolute path to the directory containing tspconfig.yaml
 * @param sdkRepoName - SDK repository name (e.g., "azure-sdk-for-python")
 * @returns EmitterCheckResult with enabled status, metadata, and packageName
 */
export async function checkEmitterEnabled(
  tspConfigDir: string,
  sdkRepoName: string,
): Promise<EmitterCheckResult> {
  const metadata = await generateTypeSpecMetadata(tspConfigDir);
  const languageKey = resolveLanguageKey(sdkRepoName, metadata.languages);
  const langMetadata = languageKey ? metadata.languages[languageKey][0] : undefined;
  if (!langMetadata) {
    logMessage(`Language emitter not enabled for ${sdkRepoName} in tspconfig.yaml`, LogLevel.Info);
    return { enabled: false, metadata, languageKey };
  }

  logMessage(
    `Language emitter enabled for ${sdkRepoName}: ${langMetadata.emitterName} (package: ${langMetadata.packageName})`,
    LogLevel.Info,
  );
  return {
    enabled: true,
    metadata,
    languageKey,
    packageName: langMetadata.packageName,
  };
}
