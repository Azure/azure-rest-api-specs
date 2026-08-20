import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { join } from "node:path";
import { context } from "../index.ts";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parseServiceYaml } from "../service-yaml.ts";
import { readFileAtCommit } from "../utils.ts";

// Scoped to management-plane SDK emitters for now.
const SDK_EMITTERS = new Set([
  "@azure-tools/typespec-python",
  "@azure-tools/typespec-java",
  "@azure-tools/typespec-ts",
  "@azure-tools/typespec-go",
  "@azure-typespec/http-client-csharp-mgmt",
]);

// For multiple-service projects, the typespec-metadata emitter reports "multiple-versions" for
// every emitter, overriding the api-version each emitter is actually configured with.
const MULTIPLE_SERVICE_API_VERSION = "multiple-versions";

const WIKI_LINK =
  "https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation#multiplenewapiversions";

function parseApiVersion(version: string) {
  const match = version.match(/^(\d{4})-(\d{2})-(\d{2})(-preview)?$/);
  if (!match) return undefined;
  return {
    year: Number(match[1]),
    month: Number(match[2]),
    day: Number(match[3]),
    isPreview: match[4] !== undefined,
  };
}

/** Compares API versions oldest first, with preview preceding stable on the same date. */
export function compareApiVersionsAsc(left: string, right: string): number {
  const leftVersion = parseApiVersion(left);
  const rightVersion = parseApiVersion(right);

  if (!leftVersion || !rightVersion) return left.localeCompare(right);
  if (leftVersion.year !== rightVersion.year) return leftVersion.year - rightVersion.year;
  if (leftVersion.month !== rightVersion.month) return leftVersion.month - rightVersion.month;
  if (leftVersion.day !== rightVersion.day) return leftVersion.day - rightVersion.day;
  if (leftVersion.isPreview !== rightVersion.isPreview) {
    return leftVersion.isPreview ? -1 : 1;
  }
  return left.localeCompare(right);
}

function getSdkLanguageMetadata(metadata: TypeSpecMetadata) {
  return Object.values(metadata.languages)
    .flat()
    .filter((language) => SDK_EMITTERS.has(language.emitterName));
}

export function evaluateApiVersionPolicy(
  metadata: TypeSpecMetadata,
  newApiVersions: string[],
): RuleResult {
  const sdkEmitters = getSdkLanguageMetadata(metadata);

  if (sdkEmitters.length === 0) {
    return {
      success: true,
      stdOutput:
        "Warning: No SDK language emitters are configured; skipping API-version validation.",
    };
  }

  if (sdkEmitters.some((emitter) => emitter.apiVersion === MULTIPLE_SERVICE_API_VERSION)) {
    return {
      success: true,
      stdOutput: "Warning: This rule does not support multiple-service project scenarios.",
    };
  }

  if (newApiVersions.length === 1) {
    const newApiVersion = newApiVersions[0];
    const warnings = sdkEmitters
      .filter(
        (emitter) =>
          emitter.apiVersion !== undefined &&
          parseApiVersion(emitter.apiVersion) !== undefined &&
          compareApiVersionsAsc(emitter.apiVersion, newApiVersion) < 0,
      )
      .map(
        (emitter) =>
          `Warning: ${emitter.emitterName} targets API version ${emitter.apiVersion}, which is ` +
          `older than newly added API version ${newApiVersion}.`,
      );

    return {
      success: true,
      stdOutput:
        warnings.length > 0
          ? warnings.join("\n")
          : `No SDK emitter targets an API version older than ${newApiVersion}.`,
    };
  }

  const oldestNewApiVersion = [...newApiVersions].sort(compareApiVersionsAsc)[0];

  // Known gap: an emitter pinned to "all" is reported here as invalid; no spec uses that value yet.
  const invalidEmitters = sdkEmitters.filter(
    (emitter) => emitter.apiVersion !== oldestNewApiVersion,
  );
  if (invalidEmitters.length > 0) {
    const details = invalidEmitters.map(
      (emitter) =>
        `  - ${emitter.emitterName}: ${emitter.apiVersion ?? "<not set>"} ` +
        `(expected ${oldestNewApiVersion})`,
    );
    return {
      success: false,
      errorOutput:
        `ERROR: This pull request adds multiple API versions. Every SDK language emitter must ` +
        `target the oldest newly added version, ${oldestNewApiVersion}:\n${details.join("\n")}\n` +
        `\nPlease refer to ${WIKI_LINK} for detailed guidance.`,
    };
  }

  return {
    success: true,
    stdOutput: `All SDK language emitters target ${oldestNewApiVersion}.`,
  };
}

export class MultipleNewApiVersionsRule implements Rule {
  readonly name = "MultipleNewApiVersions";
  readonly description = "Validate SDK API-version selection when a PR adds API versions";

  async execute(folder: string): Promise<RuleResult> {
    // Validating all specs has no pull request to diff, and runs on a shallow clone without HEAD^.
    if (context.checkingAllSpecs === true) {
      return {
        success: true,
        stdOutput: "Validating all specs; skipping comparison of newly added API versions.",
      };
    }

    // Only the pull request check supplies commits; a bare "npx tsv <folder>" has nothing to diff.
    const { baseCommitish, headCommitish } = context;
    if (typeof baseCommitish !== "string" || typeof headCommitish !== "string") {
      return {
        success: true,
        stdOutput:
          "No commits to compare; skipping. To run this rule locally, pass the commits to " +
          `compare:\n  npx tsv ${folder} '{"baseCommitish":"{commitShaOfMain}",` +
          `"headCommitish":"{headShaOfLocalBranch}"}'`,
      };
    }

    const serviceYamlPath = join(folder, "service.yaml");
    let baseSource: string | undefined;
    let headSource: string | undefined;

    try {
      [baseSource, headSource] = await Promise.all([
        readFileAtCommit(folder, baseCommitish, serviceYamlPath),
        readFileAtCommit(folder, headCommitish, serviceYamlPath),
      ]);
    } catch (error) {
      return {
        success: false,
        errorOutput:
          `Unable to compare service.yaml between ${baseCommitish} and ` +
          `${headCommitish}: ${String(error)}`,
      };
    }

    if (headSource === undefined) {
      return {
        success: true,
        stdOutput: `Warning: service.yaml does not exist at ${headCommitish}; validation skipped.`,
      };
    }

    const headService = parseServiceYaml(headSource);
    if (!headService.success) {
      return { success: false, errorOutput: `${headCommitish}: ${headService.error}` };
    }

    const baseService = baseSource === undefined ? undefined : parseServiceYaml(baseSource);
    if (baseService && !baseService.success) {
      return { success: false, errorOutput: `${baseCommitish}: ${baseService.error}` };
    }

    const baseVersions = new Set(
      baseService?.value.versions
        .filter((entry) => entry.source === "typespec")
        .map((entry) => entry.version) ?? [],
    );
    const newApiVersions = [
      ...new Set(
        headService.value.versions
          .filter((entry) => entry.source === "typespec" && !baseVersions.has(entry.version))
          .map((entry) => entry.version),
      ),
    ];

    if (newApiVersions.length === 0) {
      return { success: true, stdOutput: "No new TypeSpec API versions were added." };
    }

    try {
      const metadata = await generateTypeSpecMetadata(folder);
      const result = evaluateApiVersionPolicy(metadata, newApiVersions);
      if (result.success) {
        return result;
      }

      return {
        ...result,
        errorOutput:
          `${result.errorOutput}\n\nTo reproduce locally:\n` +
          `  npx tsv ${folder} '{"baseCommitish":"{commitShaOfMain}",` +
          `"headCommitish":"{commitShaOfPRHead}"}'`,
      };
    } catch (error) {
      return { success: false, errorOutput: String(error) };
    }
  }
}
