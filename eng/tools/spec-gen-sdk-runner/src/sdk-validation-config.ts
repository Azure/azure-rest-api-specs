/**
 * Parsing, validation, and resolution for the per-project `sdk-validation.yaml`
 * configuration file that controls the SDK Validation check.
 *
 * The only setting recognized in this iteration is a per-language `repo-branch`
 * pin, used to check out a non-`main` SDK repo branch during SDK generation in
 * the public spec-PR flow. See support-customized-branch.md at the repository root.
 */
import { SdkName } from "@azure-tools/specs-shared/sdk-types";
import fs from "node:fs";
import path from "node:path";
import { inspect } from "node:util";
import { parse as yamlParse } from "yaml";
import { LogLevel, logMessage } from "./log.ts";
import { getPlaneFolderPath, getServiceFolderPath, isValidSdkBranchName } from "./utils.ts";

/** The name of the per-project SDK Validation config file. */
export const sdkValidationConfigFileName = "sdk-validation.yaml";

/** Per-language settings inside `sdk-validation.yaml`. */
export interface SdkLanguageValidationSettings {
  "repo-branch"?: string;
}

/** Parsed shape of `sdk-validation.yaml`. */
export interface SdkValidationConfig {
  languages: Partial<Record<SdkName, SdkLanguageValidationSettings>>;
}

/** Result of validating the raw parsed content of `sdk-validation.yaml`. */
export interface SdkValidationConfigValidationResult {
  config?: SdkValidationConfig;
  errors: string[];
}

type ReadSdkValidationConfigResult =
  | { status: "absent" }
  | { status: "invalid" }
  | { status: "valid"; config: SdkValidationConfig };

const validSdkNames = new Set<string>(Object.values(SdkName));
const allowedRootKeys = new Set(["languages"]);
const allowedLanguageSettingKeys = new Set(["repo-branch"]);

/**
 * Validate the raw parsed content of an `sdk-validation.yaml` file.
 *
 * Keeps validation lightweight and dependency-free (the schema is tiny): checks
 * shape, restricts language keys to the `SdkName` enum, restricts per-language
 * keys to `repo-branch`, and validates the branch name via `isValidSdkBranchName`.
 */
export function validateSdkValidationConfig(content: unknown): SdkValidationConfigValidationResult {
  const errors: string[] = [];

  if (content === null || content === undefined) {
    return { errors: [`${sdkValidationConfigFileName} is empty.`] };
  }
  if (typeof content !== "object" || Array.isArray(content)) {
    return { errors: [`${sdkValidationConfigFileName} root must be a mapping.`] };
  }

  const root = content as Record<string, unknown>;
  for (const key of Object.keys(root)) {
    if (!allowedRootKeys.has(key)) {
      errors.push(`Unexpected top-level key '${key}'. Only 'languages' is allowed.`);
    }
  }

  const languages = root["languages"];
  if (languages === undefined) {
    errors.push("Missing required 'languages' mapping.");
    return { errors };
  }
  if (typeof languages !== "object" || languages === null || Array.isArray(languages)) {
    errors.push("'languages' must be a mapping of SDK language to settings.");
    return { errors };
  }

  const parsed: SdkValidationConfig = { languages: {} };
  for (const [language, settings] of Object.entries(languages as Record<string, unknown>)) {
    if (!validSdkNames.has(language)) {
      errors.push(`Unknown SDK language '${language}'. Allowed: ${[...validSdkNames].join(", ")}.`);
      continue;
    }
    if (typeof settings !== "object" || settings === null || Array.isArray(settings)) {
      errors.push(`Settings for '${language}' must be a mapping.`);
      continue;
    }

    const settingsObj = settings as Record<string, unknown>;
    for (const key of Object.keys(settingsObj)) {
      if (!allowedLanguageSettingKeys.has(key)) {
        errors.push(
          `Unexpected setting '${key}' for '${language}'. Only 'repo-branch' is allowed.`,
        );
      }
    }

    const entry: SdkLanguageValidationSettings = {};
    const repoBranch = settingsObj["repo-branch"];
    if (repoBranch !== undefined) {
      if (typeof repoBranch !== "string") {
        errors.push(`'repo-branch' for '${language}' must be a string.`);
      } else if (!isValidSdkBranchName(repoBranch)) {
        errors.push(
          `'repo-branch' value '${repoBranch}' for '${language}' is not a valid branch name.`,
        );
      } else {
        entry["repo-branch"] = repoBranch;
      }
    }
    (parsed.languages as Record<string, SdkLanguageValidationSettings>)[language] = entry;
  }

  if (errors.length > 0) {
    return { errors };
  }
  return { config: parsed, errors };
}

/**
 * Read and validate an `sdk-validation.yaml` file. An absent file is
 * distinguished from an invalid file so resolution may continue to a less
 * specific config only when no file exists. Invalid files are logged and force
 * the default `main` branch without hard-failing generation.
 */
function readSdkValidationConfig(absolutePath: string): ReadSdkValidationConfigResult {
  if (!fs.existsSync(absolutePath)) {
    return { status: "absent" };
  }

  let raw: string;
  try {
    raw = fs.readFileSync(absolutePath, "utf8");
  } catch (error) {
    logMessage(`Failed to read ${absolutePath}: ${inspect(error)}`, LogLevel.Warn);
    return { status: "invalid" };
  }

  let parsedYaml: unknown;
  try {
    parsedYaml = yamlParse(raw);
  } catch (error) {
    logMessage(`Failed to parse ${absolutePath}: ${inspect(error)}`, LogLevel.Warn);
    return { status: "invalid" };
  }

  if (parsedYaml === null || parsedYaml === undefined) {
    logMessage(
      `Invalid ${sdkValidationConfigFileName} at ${absolutePath}: file is empty.`,
      LogLevel.Warn,
    );
    return { status: "invalid" };
  }

  const { config, errors } = validateSdkValidationConfig(parsedYaml);
  if (errors.length > 0 || !config) {
    for (const error of errors) {
      logMessage(
        `Invalid ${sdkValidationConfigFileName} at ${absolutePath}: ${error}`,
        LogLevel.Warn,
      );
    }
    return { status: "invalid" };
  }
  return { status: "valid", config };
}

/**
 * Resolve the SDK repo branch pin for a given spec config and SDK language.
 *
 * Looks up `sdk-validation.yaml` at project level (next to the spec config),
 * then API plane level (`resource-manager` or `data-plane`), then service
 * level. Returns the validated branch name, or `undefined` when there is no
 * pin, the pin is `main`, or the config is invalid (all treated as "use
 * `main`").
 *
 * @param specConfigRelativePath - Relative path to the spec config (e.g.
 *   `specification/foo/Foo.Management/tspconfig.yaml` or `.../readme.md`).
 * @param sdkName - The SDK language being generated.
 * @param localSpecRepoPath - Absolute path to the local spec repo checkout.
 */
export function resolveSdkRepoBranch(
  specConfigRelativePath: string,
  sdkName: SdkName,
  localSpecRepoPath: string,
): string | undefined {
  const normalizedSpecConfigPath = specConfigRelativePath.replaceAll("\\", "/");
  const candidateDirs = [
    path.posix.dirname(normalizedSpecConfigPath),
    getPlaneFolderPath(normalizedSpecConfigPath),
    getServiceFolderPath(normalizedSpecConfigPath),
  ];
  const seenDirs = new Set<string>();

  for (const dir of candidateDirs) {
    if (!dir || dir === "." || seenDirs.has(dir)) {
      continue;
    }
    seenDirs.add(dir);

    const absolutePath = path.join(localSpecRepoPath, dir, sdkValidationConfigFileName);
    const configResult = readSdkValidationConfig(absolutePath);
    if (configResult.status === "absent") {
      continue;
    }
    if (configResult.status === "invalid") {
      logMessage(
        `Invalid ${sdkValidationConfigFileName} at ${path.join(dir, sdkValidationConfigFileName)}; using 'main' for ${sdkName}.`,
        LogLevel.Warn,
      );
      return undefined;
    }

    const branch = configResult.config.languages?.[sdkName]?.["repo-branch"];
    if (branch === undefined) {
      // This level has a config but no pin for this language; fall through.
      continue;
    }
    if (branch === "main") {
      // Explicit `main` at the more specific level is a no-op; stop resolving.
      logMessage(
        `SDK repo branch for ${sdkName} is explicitly set to 'main' in ${path.join(dir, sdkValidationConfigFileName)}; using 'main' (no branch override).`,
        LogLevel.Info,
      );
      return undefined;
    }
    logMessage(
      `Resolved SDK repo branch '${branch}' for ${sdkName} from ${path.join(dir, sdkValidationConfigFileName)}`,
      LogLevel.Info,
    );
    return branch;
  }

  logMessage(`No SDK repo branch override found for ${sdkName}; using 'main'.`, LogLevel.Info);
  return undefined;
}
