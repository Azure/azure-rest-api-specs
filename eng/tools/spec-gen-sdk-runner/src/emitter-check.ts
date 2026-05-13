import fs from "node:fs";
import path from "node:path";
import { inspect } from "node:util";
import { LogLevel, logMessage } from "./log.js";
import { execAsync } from "./utils.js";

/**
 * Metadata output from the @azure-tools/typespec-metadata emitter.
 */
export interface TypeSpecMetadata {
  emitterVersion: string;
  generatedAt: string;
  typespec: {
    namespace: string;
    documentation?: string;
    type: "data" | "management";
  };
  languages: Record<string, LanguageMetadata[]>;
  sourceConfigPath: string;
}

export interface LanguageMetadata {
  emitterName: string;
  packageName: string;
  namespace?: string;
  outputDir?: string;
  flavor?: string;
  serviceDir?: string;
}

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
function resolveLanguageKey(
  sdkRepoName: string,
  languages: Record<string, LanguageMetadata[]>,
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
  const metadataOutputDir = path.join(tspConfigDir, "@azure-tools", "typespec-metadata");

  try {
    // Run tsp compile with the typespec-metadata emitter using default options.
    // Override output-dir to tspConfigDir so the metadata file lands in a
    // predictable location regardless of the tspconfig.yaml output-dir setting.
    // Use npx to resolve the locally-installed tsp binary from node_modules/.bin.
    const tspCommand = [
      "npx tsp compile",
      `"${tspConfigDir}"`,
      '--emit "@azure-tools/typespec-metadata"',
      `--output-dir "${tspConfigDir}"`,
      '--option "@azure-tools/typespec-metadata.format=json"',
    ].join(" ");

    logMessage(`Running typespec-metadata emitter: ${tspCommand}`, LogLevel.Debug);
    const { stderr } = await execAsync(tspCommand, { cwd: tspConfigDir });
    if (stderr) {
      logMessage(`typespec-metadata emitter warnings: ${stderr}`, LogLevel.Warn);
    }

    // Find the metadata JSON file
    const jsonPath = path.join(metadataOutputDir, "typespec-metadata.json");
    if (!fs.existsSync(jsonPath)) {
      logMessage(`typespec-metadata output not found in ${metadataOutputDir}`, LogLevel.Error);
      return { enabled: false };
    }

    const raw = fs.readFileSync(jsonPath, "utf8");
    const metadata = JSON.parse(raw) as TypeSpecMetadata;

    // Check if the target language is configured
    const languageKey = resolveLanguageKey(sdkRepoName, metadata.languages);
    if (!languageKey) {
      logMessage(
        `Language emitter not enabled for ${sdkRepoName} in tspconfig.yaml`,
        LogLevel.Info,
      );
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
  } catch (error) {
    logMessage(`Error running typespec-metadata emitter: ${inspect(error)}`, LogLevel.Error);
    return { enabled: false };
  } finally {
    // Clean up the metadata output directory
    try {
      if (fs.existsSync(metadataOutputDir)) {
        fs.rmSync(metadataOutputDir, { recursive: true });
      }
    } catch {
      // Ignore cleanup errors
    }
  }
}
