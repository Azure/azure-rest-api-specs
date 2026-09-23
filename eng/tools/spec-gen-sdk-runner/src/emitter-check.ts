import type { ILogger } from "@azure-tools/specs-shared/logger";
import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { LogLevel, logMessage } from "./log.ts";

export interface EmitterCheckResult {
  enabled: boolean;
  metadata?: TypeSpecMetadata;
  languageKey?: string;
  packageName?: string;
}

const logger: ILogger = {
  debug: (message) => logMessage(message, LogLevel.Debug),
  error: (message) => logMessage(message, LogLevel.Error),
  info: (message) => logMessage(message, LogLevel.Info),
  warning: (message) => logMessage(message, LogLevel.Warn),
  isDebug: () => true,
};

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
 * Runs the typespec-metadata emitter to check if the target language emitter
 * is enabled in the tspconfig.yaml and extracts package metadata.
 *
 * @param tspConfigDir - Absolute path to the directory containing tspconfig.yaml
 * @param sdkRepoName - SDK repository name (e.g., "azure-sdk-for-python")
 * @throws If metadata cannot be generated or validated.
 */
export async function checkEmitterEnabled(
  tspConfigDir: string,
  sdkRepoName: string,
): Promise<EmitterCheckResult> {
  const metadata = await generateTypeSpecMetadata(tspConfigDir, { logger });
  const candidates = SDK_REPO_TO_LANGUAGE_KEY[sdkRepoName.replace("-pr", "")];
  const languageKey = candidates?.find((key) => metadata.languages[key]?.length > 0);
  if (!languageKey) {
    logMessage(`Language emitter not enabled for ${sdkRepoName} in tspconfig.yaml`, LogLevel.Info);
    return { enabled: false, metadata, languageKey: undefined };
  }

  const langMetadata = metadata.languages[languageKey][0];
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
